module Minesweeper
  class App
    BOMB_PERCENT = 0.75
    MAX_ROW_NUM = 20

    attr_accessor :game, :cli

    def initialize
      cli = CLI.new
      self.cli = cli
      game_config = cli.start
      game = Game.new(game_config.first, game_config.last)
      self.game = game
    end

    def start
      play_game
      end_game
    end

    def play_game
      while !game_is_over
        move = nil
        while game.is_not_valid?(move)
          if move != nil
            cli.invalid_move
          end
          move = cli.get_move(game)
        end
        game.place_move(move)
      end
    end

    def end_game
      result = game.check_win_or_loss
      cli.show_game_over_message(result)
    end

    def game_is_over
      game.gameloop_check_status
    end

  end
end
