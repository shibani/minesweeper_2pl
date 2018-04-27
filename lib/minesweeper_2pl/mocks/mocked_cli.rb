module Minesweeper_2pl
  class MockedCli < CLI

    def print(msg)
    end

    def ask_for_move
    end

    def get_player_input(game)
      [3,3]
    end

    def show_game_over_message
    end
  end
end
