module Minesweeper_2pl
  class Game
    attr_accessor :cli, :board

    def printBoard
      self.cli.print(self.board)
    end

    def setup
    end
  end
end
