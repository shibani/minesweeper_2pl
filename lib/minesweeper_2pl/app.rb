module Minesweeper_2pl
  class App
    SIZE = 100
    BOMB_COUNT = 10
    attr_accessor :game, :cli

    def start
      self.setup
      self.play_game
    end

    def setup
      game = Game.new
      cli = CLI.new
      self.cli = cli
      self.game = game
      self.game.setup(SIZE, BOMB_COUNT)
    end

    def play_game
      self.game.print_board
      self.cli.ask_for_move
      self.cli.get_player_input
    end
  end
end
