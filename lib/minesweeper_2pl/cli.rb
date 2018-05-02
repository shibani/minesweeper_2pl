module Minesweeper

  # class InputGetter
  # end
  #
  # class Printer
  # end
  #
  # class InputValidator
  #   def self.bomb_count_input_has_correct_format(input)
  #     input.match(/^(\d)+$/)
  #   end
  #
  #   def self.bomb_count_within_range?(input, board_size)
  #     input.to_i > 0 && input.to_i <= board_size * App::BOMB_PERCENT
  #   end
  # end
  #
  # class Messages
  # end

  class CLI
    def print(msg)
      puts msg
    end

    def start
      print(welcome)
      get_player_params
    end

    def get_move(game)
      ask_for_move
      get_player_input(game)
    end

    def get_player_params
      result = []
      size = nil
      while size.nil?
        ask_for_board_size
        size = get_player_entered_board_size
      end
      result << size
      count = nil
      while count.nil?
        ask_for_bomb_count(size)
        count = get_player_entered_bomb_count(size * size)
      end
      result << count
      result
    end

    def get_player_input(game)
      input = gets.chomp
      if player_input_has_correct_format(input)
        return_coordinates_if_input_is_within_range(input, game)
      else
        puts invalid_player_input_message
      end
    end

    def get_player_entered_board_size
      input = gets.chomp
      if board_size_input_has_correct_format(input)
        return_row_size_if_input_is_within_range(input)
      else
        puts invalid_row_size_message
      end
    end

    def get_player_entered_bomb_count(board_size)
      input = gets.chomp
      if bomb_count_input_has_correct_format(input)
        return_bomb_count_if_input_is_within_range(input, board_size)
      else
        puts invalid_bomb_count_message
      end
    end

    def welcome
      "\n===========================================\n           WELCOME TO MINESWEEPER\n===========================================\n\n"
    end

    def ask_for_move
      string = "\nPlayer 1, make your move:\n- to place a move: enter the word 'move' followed by one digit from the header and one digit from the left column, eg. move 3,1:\n- to place (or remove) a flag: enter the word 'flag' followed by the desired coordinates eg flag 3,1\n"
      print(string)
    end

    def ask_for_board_size
      puts "Player 1 please enter a row size for your board, any number less than or equal to 20. \n(Entering 20 will give you a 20X20 board)\n"
    end

    def ask_for_bomb_count(size)
      puts "Player 1 please enter the number of bombs there should be on the board. \n(The number should not be more than #{(size * size * App::BOMB_PERCENT).to_i})"
    end

    def show_game_over_message(result)
      if result == "win"
        "Game over! You win!"
      elsif result == "lose"
        "Game over! You lose."
      end
    end

    def invalid_move
      puts "That was not a valid move. Please try again."
    end

    private

    def player_input_has_correct_format(input)
      input =~ (/(flag|move)\s+[(\d){1,2}],\s*[(\d){1,2}]/)
    end

    def player_input_is_within_range?(coords, game)
      (coords[0].to_i <= game.board.row_size) && (coords[1].to_i <= game.board.row_size)
    end

    def return_coordinates_if_input_is_within_range(input, game)
      move = input.split(" ")
      coords = move[1].split(",")
      if player_input_is_within_range?(coords, game)
        puts player_input_success_message(input)
        coords = [coords[0].to_i, coords[1].to_i, move[0]]
      else
        puts invalid_player_input_message
        coords = nil
      end
      coords
    end

    def player_input_success_message(input)
      move = input.split(" ")
      "You selected #{input}. Placing your #{move[0]}."
    end

    def invalid_player_input_message
      "Expecting 'flag' or 'move', with one digit from header and one digit from left column. Please try again!"
    end

    def board_size_input_has_correct_format(input)
      # InputValidator.board_size_input_has_correct_format(input)
      input.match(/^(\d)+$/)
        end

    def row_size_within_range?(input)
      input.to_i > 0 && input.to_i <= App::MAX_ROW_NUM
    end

    def return_row_size_if_input_is_within_range(input)
      if row_size_within_range?(input)
        puts row_size_success_message(input)
        row_size = input.to_i
      else
        puts invalid_row_size_message
        row_size = nil
      end
      row_size
    end

    def row_size_success_message(input)
      puts "You have selected a #{input} x #{input} board. Generating board."
    end

    def invalid_row_size_message
      "That is not a valid row size. Please try again."
    end

    def bomb_count_input_has_correct_format(input)
      input.match(/^(\d)+$/)
    end

    def bomb_count_within_range?(input, board_size)
      input.to_i > 0 && input.to_i <= board_size * App::BOMB_PERCENT
    end

    def bomb_count_success_message(input)
      puts "You selected #{input}. Setting bombs!"
    end

    def return_bomb_count_if_input_is_within_range(input, board_size)
      if bomb_count_within_range?(input, board_size)
        puts bomb_count_success_message(input)
        bomb_count = input.to_i
      else
        puts invalid_bomb_count_message
        bomb_count = nil
      end
      bomb_count
    end

    def invalid_bomb_count_message
      "That is not a valid bomb count. Please try again."
    end
  end
end
