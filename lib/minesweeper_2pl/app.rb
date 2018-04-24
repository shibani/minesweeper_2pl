module Minesweeper
  class App
    BOMB_PERCENT = 0.75
    MAX_ROW_NUM = 20

    attr_accessor :game, :cli

    # def initialize
    #   result = ui_setup
    #   create_game(result)
    # end

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
      while !game_is_over
        move = nil
        while game.is_not_valid?(move)
          move = cli.get_move(game)
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
      game = Game.new(game_config.first, game_config.last)
      self.game = game
      #game.setup(game_config.first, game_config.last)
    end

    def game_is_over
      game.gameloop_check_status
    end

  end
end
