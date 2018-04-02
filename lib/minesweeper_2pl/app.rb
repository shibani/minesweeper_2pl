module Minesweeper_2pl
  class App
    SIZE = 100
    attr_accessor :game, :cli

    def start
      game = Game.new
      cli = CLI.new
      self.cli = cli
      self.game = game
      self.setup
    end

    def setup
      self.game.setup(Minesweeper_2pl::App::SIZE)
    end
  end
end
