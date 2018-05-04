module Minesweeper
  class CLI
    def print(msg)
      puts(msg)
    end

    def start
      print(Messages.welcome)
      get_player_params
    end

    def get_move(game)
      Messages.ask_for_move
      get_player_input(game)
    end

    def get_player_params
      result = []
      size = nil
      while size.nil?
        Messages.ask_for_board_size
        size = get_player_entered_board_size
      end
      result << size
      count = nil
      while count.nil?
        Messages.ask_for_bomb_count(size)
        count = get_player_entered_bomb_count(size * size)
      end
      result << count
      result
    end

    def get_player_input(game)
      input = gets.chomp
      if InputValidator.player_input_has_correct_format(input)
        InputValidator.return_coordinates_if_input_is_within_range(input, game)
      else
        puts Messages.invalid_player_input_message
      end
    end

    def get_player_entered_board_size
      input = gets.chomp
      if InputValidator.board_size_input_has_correct_format(input)
        InputValidator.return_row_size_if_input_is_within_range(input)
      else
        puts Messages.invalid_row_size_message
      end
    end

    def get_player_entered_bomb_count(board_size)
      input = gets.chomp
      if InputValidator.bomb_count_input_has_correct_format(input)
        InputValidator.return_bomb_count_if_input_is_within_range(input, board_size)
      else
        puts Messages.invalid_bomb_count_message
      end
    end
  end
end
