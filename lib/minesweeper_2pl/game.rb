module Minesweeper
  class Game
    attr_accessor :board, :board_formatter, :game_over

    def initialize(row_size, bomb_count=0)
      board_formatter = BoardFormatter.new
      board = Board.new(row_size, bomb_count)

      self.board = board
      set_board_positions(row_size)
      self.board_formatter = board_formatter
    end

    def print_board
      board_array = board_formatter.format_board_with_emoji(board)
      string = board_formatter.board_to_string(board_array, board)
      board_formatter.print_message(string)
    end

    def row_size
      board.row_size
    end

    def bomb_count
      board.bomb_count
    end

    def set_bomb_positions(array)
      board.bomb_positions = array
    end

    def bomb_positions
      board.bomb_positions
    end

    def set_positions(array)
      board.positions = array
    end

    def get_position(move)
      position = move_to_position(move)
      board_positions[position]
    end

    def board_positions
      board.positions
    end

    def set_board_positions(size)
      board.set_positions(size * size)
    end

    def place_move(move)
      position = move_to_position(move)
      if move.last == 'move'
        mark_move_on_board(position)
      elsif move.last == 'flag'
        mark_flag_on_board(position)
      end
      self.game_over = true if is_won?
    end

    def show_bombs=(msg)
      if msg == "show"
        board_formatter.show_bombs = "show"
      elsif msg == "won"
        board_formatter.show_bombs = "won"
      else
        board_formatter.show_bombs = false
      end
    end

    def is_won?
      all_non_bomb_positions_are_marked? && all_bomb_positions_are_flagged?
    end

    def is_not_valid?(move=nil)
      move.nil? || get_position(move) == "X"
    end

    def gameloop_check_status
      print_board if game_over != true
      game_over
    end

    def check_win_or_loss
      if game_over
        if is_won?
          self.show_bombs = "won"
          print_board
          result = "win"
        else
          self.show_bombs = "show"
          print_board
          result = "lose"
        end
      end
      result
    end

    def mark_move_on_board(position)
      if position_is_a_bomb?(position)
        self.game_over = true
      else
        board.show_adjacent_empties_with_value(position)
        mark_board(position, "X")
      end
    end

    def mark_flag_on_board(position)
      if position_is_empty?(position)
        mark_board(position, "F")
      elsif position_is_flag?(position)
        mark_board(position, " ")
      elsif position_includes_a_flag?(position)
        el = board_positions[position].delete("F")
        mark_board(position, el)
      elsif position_is_a_user_move?(position)
        board_positions[position]
      else
        board_positions[position] += "F"
      end
    end

    private

    def move_to_position(move)
      if move.is_a? Array
        move[0] + board.row_size * move[1]
      else
        raise
      end
    end

    def position_to_move(position)
      [
        (position % board.row_size).to_i,
        (position / board.row_size).to_i
      ]
    end

    def position_is_a_bomb?(position)
      board.bomb_positions.include?(position)
    end

    def position_is_empty?(position)
      board.positions[position] == " "
    end

    def position_is_flag?(position)
      board.positions[position] == "F"
    end

    def position_includes_a_flag?(position)
      board.positions[position].include?("F")
    end

    def position_is_a_user_move?(position)
      board.positions[position] == "X"
    end

    def mark_board(position, content)
      board.positions[position] = content
    end

    def all_non_bomb_positions_are_marked?
      board_positions.size - bomb_positions.size == board_positions.select{ |el| el == "X" }.length
    end

    def all_bomb_positions_are_flagged?
      bomb_positions.size == board_positions.select{ |el| el.include?('F') }.length
    end
  end
end
