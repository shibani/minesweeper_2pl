module Minesweeper
  class MockCli < CLI
    attr_accessor :count

    def initialize
      @count = 0
    end

    def reset_count
      @count = 0
    end

    def set_input!(*args)
      @inputs = []
      args.each do |arg|
        @inputs << arg
      end
      @inputs
    end

    def print(msg)
    end

    def get_player_params
      result = []
      size = get_player_entered_board_size
      result << size

      count = get_player_entered_bomb_count(size * size)
      result << count
      result
    end

    def ask_for_move
    end

    def get_player_input(game)
      result = @inputs[@count]
      @count += 1
      result
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
