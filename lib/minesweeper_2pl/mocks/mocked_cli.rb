module Minesweeper_2pl
  class MockedCli < CLI

    def set_input!(input)
      @input = input
    end

    def print(msg)
    end

    def get_player_params
      result = []
      size = self.get_player_entered_board_size
      result << size

      count = self.get_player_entered_bomb_count(size * size)
      result << count
      result
    end

    def ask_for_move
    end

    def get_player_input(game)
      @input
    end

    def show_game_over_message
    end

    def ask_for_board_size
    end

    def ask_for_bomb_count(size)
    end

    def get_player_entered_board_size
      10
    end

    def get_player_entered_bomb_count(board_size)
      70
    end

    def welcome
    end

  end
end
