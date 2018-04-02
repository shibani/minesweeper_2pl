module Minesweeper_2pl
  class Game
    attr_accessor :bcli, :board

    def printBoard
      self.bcli.print(self.board)
    end

    def setup
    end
  end
end
