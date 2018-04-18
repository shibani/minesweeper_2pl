module Minesweeper_2pl
  class App
    SIZE = 100
    BOMB_COUNT = 10
    BOMB_PERCENT = 0.75

    attr_accessor :game, :cli

    def start
      self.setup
      self.play_game
      self.end_game
    end

    def setup
      result = ui_setup
      create_game(result)
    end

    def play_game
      while self.game.game_over != true
        self.game.print_board
        move = nil
        while move == nil
          self.cli.ask_for_move
          move = self.cli.get_player_input(self.game)
        end
        game.place_move(move)
      end
    end

    def end_game
      if self.game.game_over
        if game.is_won?
          self.game.show_bombs = "won"
          self.game.print_board
          cli.show_game_won_message
        else
          self.game.show_bombs = true
          self.game.print_board
          cli.show_game_over_message
        end
      end
    end

    def ui_setup
      cli = CLI.new
      self.cli = cli
      cli.start
    end

    def create_game(game_config)
      game = Game.new
      self.game = game
      game.setup(game_config.first, game_config.last)
    end

  end
end
