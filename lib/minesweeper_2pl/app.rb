module Minesweeper_2pl
  class App
    attr_accessor :game, :cli

    def call
      self.game.setup
    end
  end
end
