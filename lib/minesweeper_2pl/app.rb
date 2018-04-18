module Minesweeper_2pl
  class App
    SIZE = 100
    BOMB_COUNT = 10
    BOMB_PERCENT = 0.75

    attr_accessor :game, :cli

    def start
      setup
      play_game
      end_game
    end

    def setup
      result = ui_setup
      create_game(result)
    end

    def play_game
      while game.game_over != true
        game.print_board
        move = nil
        while move == nil
          cli.ask_for_move
          move = cli.get_player_input(game)
        end
        game.place_move(move)
      end
    end

    def end_game
      result = game.check_game_status
      cli.show_game_over_message(result)
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
