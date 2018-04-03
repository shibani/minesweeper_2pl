module Minesweeper_2pl
  class Game
    attr_accessor :bcli, :board

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
      self.bcli.show_bombs = false
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
  end
end
