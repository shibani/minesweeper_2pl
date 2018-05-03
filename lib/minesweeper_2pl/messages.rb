module Minesweeper
  class Messages
    def self.welcome
      "\n===========================================\n           WELCOME TO MINESWEEPER\n===========================================\n\n"
    end

    def self.ask_for_move
      string = "\nPlayer 1, make your move:\n- to place a move: enter the word 'move' followed by one digit from the header and one digit from the left column, eg. move 3,1:\n- to place (or remove) a flag: enter the word 'flag' followed by the desired coordinates eg flag 3,1\n"
      print(string)
    end

    def self.ask_for_board_size
      puts "Player 1 please enter a row size for your board, any number less than or equal to 20. \n(Entering 20 will give you a 20X20 board)\n"
    end

    def self.ask_for_bomb_count(size)
      puts "Player 1 please enter the number of bombs there should be on the board. \n(The number should not be more than #{(size * size * App::BOMB_PERCENT).to_i})"
    end

    def self.invalid_move
      puts "That was not a valid move. Please try again."
    end

    def self.invalid_bomb_count_message
      "That is not a valid bomb count. Please try again."
    end

    def self.bomb_count_success_message(input)
      puts "You selected #{input}. Setting bombs!"
    end

    def self.show_game_over_message(result)
      if result == "win"
        "Game over! You win!"
      elsif result == "lose"
        "Game over! You lose."
      end
    end

    def self.invalid_player_input_message
      "Expecting 'flag' or 'move', with one digit from header and one digit from left column. Please try again!"
    end

    def self.row_size_success_message(input)
      puts "You have selected a #{input} x #{input} board. Generating board."
    end

    def self.invalid_row_size_message
      "That is not a valid row size. Please try again."
    end

    def self.player_input_success_message(input)
      move = input.split(" ")
      "You selected #{input}. Placing your #{move[0]}."
    end
  end
end
