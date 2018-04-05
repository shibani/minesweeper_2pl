module Minesweeper_2pl
  class Game
    attr_accessor :bcli, :board, :game_over

    def setup(board_size, bomb_count)
      bcli = BoardCli.new
      board = Board.new

      self.board = board
      self.set_board_size(board_size)
      self.set_bomb_count(bomb_count)
      self.set_board_positions(board_size)
      self.bcli = bcli
    end

    def print_board
      positions = self.board_positions
      rowsize = self.board.row_size
      self.bcli.set_board(positions, rowsize)
      self.bcli.print_message(self.bcli.board)
    end

    def set_board_size(board_size)
      self.board.size = board_size
    end

    def set_bomb_count(bomb_count)
      self.board.bomb_count = bomb_count
    end

    def board_positions
      self.board.positions
    end

    def set_board_positions(size)
      self.board.set_positions(size)
    end

    def move_to_coordinates(move)
      move[0] + self.board.row_size * move[1]
    end

    def place_move(coords)
      if self.board.bomb_positions.include?(coords)
        self.game_over = true
      else
        self.board.positions[coords] = "X"
      end
    end

    def show_bombs=(msg)
      if msg == true
        self.bcli.show_bombs = true
      else
        self.bcli.show_bombs = false
      end
    end
  end
end
