module Minesweeper_2pl
  class Game
    attr_accessor :bcli, :board

    def printBoard
      self.bcli.print(self.board)
    end

    def setup(size)
      bcli = BoardCli.new
      board = Board.new
      self.board = board
      self.board.size = size
      self.bcli = bcli
    end
  end
end
