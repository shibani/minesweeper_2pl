module Minesweeper
  class MockApp < App

    SIZE = 100
    BOMB_COUNT = 10
    BOMB_PERCENT = 0.75

    attr_accessor :game, :cli

    def ui_setup
      cli = MockCli.new
      self.cli = cli
      cli.start
    end

    def create_game(game_config)
      game = MockGame.new
      self.game = game
      game.setup(10,70)
    end

  end
end
