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
      bcli.board_to_string(self.board)
      bcli.print_message(self.bcli.board)
    end

    def set_row_size(row_size)
      self.board.row_size = row_size
    end

    def set_board_size(row_size)
      self.board.size = row_size * row_size
    end

    def set_bomb_count(bomb_count)
      self.board.bomb_count = bomb_count
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
        if board.bomb_positions.include?(position)
          self.game_over = true
        else
          board.show_adjacent_empties_with_value(position)
          board.positions[position] = "X"
        end
      elsif move.last == "flag"
        if board.positions[position] == " "
          board.positions[position] = "F"
        elsif board.positions[position] == "F"
          board.positions[position] = " "
        elsif board.positions[position].include?("F")
          el = board.positions[position].gsub("F", "")
          board.positions[position] = el
        else
          board.positions[position] += "F"
        end
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

    def check_game_status
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

  end
end
