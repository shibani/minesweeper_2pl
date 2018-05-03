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

    def get_player_params
      result = []
      size = get_player_entered_board_size
      result << size

      count = get_player_entered_bomb_count(size * size)
      result << count
      result
    end

    def get_move(game)
      get_player_input(game)
    end

    def get_player_input(game)
      result = @inputs[@count]
      @count += 1
      result
    end

    def get_player_entered_board_size
      10
    end

    def get_player_entered_bomb_count(board_size)
      70
    end

    # def welcome
    # end
    #
    # def ask_for_move
    # end
    #
    # def ask_for_board_size
    # end
    #
    # def ask_for_bomb_count(size)
    # end
    #
    # def show_game_over_message(result)
    # end
    #
    # def invalid_move
    # end

  end
end
