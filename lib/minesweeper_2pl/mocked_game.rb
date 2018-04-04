module Minesweeper_2pl
  class MockedGame < Game
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
    end

    def set_board_size(board_size)
    end

    def set_bomb_count(bomb_count)
    end

    def board_positions
    end

    def set_board_positions(size)
    end
  end
end
