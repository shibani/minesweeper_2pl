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

    def get_player_params
      result = []
      size = self.get_player_entered_board_size
      result << size

      count = self.get_player_entered_bomb_count(size * size)
      result << count
      result
    end
    
  end
end
