module Minesweeper_2pl
  class App
    SIZE = 100
    BOMB_COUNT = 80
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
      while self.game.game_over != true
        self.game.print_board
        move = nil
        while move == nil
          self.cli.ask_for_move
          move = self.cli.get_player_input(self.game)
        end
        self.game.place_move(move)
      end
      if self.game.game_over
        self.game.show_bombs = true
        self.game.print_board
        self.cli.show_game_over_message
      end
    end
  end
end
