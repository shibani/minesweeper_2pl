module Minesweeper
  class Game
    attr_accessor :bcli, :board, :game_over

    def initialize(row_size, bomb_count)
      bcli = BoardCli.new
      board = Board.new

      self.board = board
      set_row_size(row_size)
      set_board_size(row_size)
      set_bomb_count(bomb_count)
      set_board_positions(row_size)
      self.bcli = bcli
    end

    def print_board
      positions = board_positions
      rowsize = board.row_size
      string = bcli.board_to_string(self.board)
      bcli.print_message(string)
    end

    def set_row_size(row_size)
      self.board.row_size = row_size
    end

    def row_size
      board.row_size
    end

    def set_board_size(row_size)
      self.board.size = row_size * row_size
    end

    def set_bomb_count(bomb_count)
      self.board.bomb_count = bomb_count
    end

    def bomb_count
      board.bomb_count
    end

    def set_bomb_positions(array)
      self.board.bomb_positions = array
    end

    def bomb_positions
      board.bomb_positions
    end

    def set_positions(array)
      self.board.positions = array
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
      if move.last == "move"
        move_to_board(position)
      elsif move.last == "flag"
        flag_to_board(position)
      end
      self.game_over = true if self.is_won?
    end

    def show_bombs=(msg)
      if msg == "show"
        bcli.show_bombs = "show"
      elsif msg == "won"
        bcli.show_bombs = "won"
      else
        bcli.show_bombs = false
      end
    end

    def is_won?
      (board.size - board.bomb_count == board.positions.select{|el| el == "X"}.length) && (board.bomb_count == board.positions.select{|el| el.include?("F")}.length)
    end

    def is_not_valid?(move=nil)
      move == nil || get_position(move) == "X"
    end

    def gameloop_check_status
      if game_over != true
        print_board
      end
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

    def move_to_board(position)
      if position_is_a_bomb?(position)
        self.game_over = true
      else
        board.show_adjacent_empties_with_value(position)
        mark_board(position, "X")
      end
    end

    def flag_to_board(position)
      if position_is_empty?(position)
        mark_board(position, "F")
      elsif position_is_flag?(position)
        mark_board(position, " ")
      elsif position_includes_a_flag?(position)
        el = board_positions[position].gsub("F", "")
        mark_board(position, el)
      else
        board_positions[position] += "F"
      end
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

    def mark_board(position, content)
      board.positions[position] = content
    end

  end
end
