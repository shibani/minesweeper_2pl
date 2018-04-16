module Minesweeper_2pl
  class CLI

    def print(msg)
      puts msg
    end

    def get_player_params
      result = []
      size = nil
      while size == nil
        self.ask_for_board_size
        size = self.get_player_entered_board_size
      end
      result << size
      count = nil
      while count == nil
        self.ask_for_bomb_count(size)
        count = self.get_player_entered_bomb_count(size * size)
      end
      result << count
      result
    end

    def ask_for_move
      string = "\nPlayer 1, make your move:\n- to place a move: enter the word 'move' followed by one digit for the row (from left) and one digit for the column (from top) to make your move, eg. 3,1:\n- to place (or remove) a flag: enter the word 'flag' followed by the desired coordinates eg flag 3,1\n"
      self.print(string)
    end

    def get_player_input(game)
      input = gets.chomp
      if input =~ (/[flag|move]\s*[(\d){1,2}],\s*[(\d){1,2}]/)
        move = input.split(" ")
        coords = move[1].split(",")
        if ((coords[0].to_i <= game.board.row_size) && (coords[1].to_i <= game.board.row_size))
          puts "You selected #{input}. Placing your #{move[0]}."
          coords = [coords[0].to_i, coords[1].to_i, move[0]]
        else
          puts "Expecting 'flag' or 'move', with one digit for the row (from left) and one digit for the column (from top). Please try again!"
          coords = nil
        end
      else
        puts "Expecting 'flag' or 'move', with one digit for the row (from left) and one digit for the column (from top). Please try again!"
        coords = nil
      end
      coords
    end

    def show_game_over_message
      puts "Game over! You lose."
    end

    def ask_for_board_size
      puts "Player 1 please enter a row size for your board, any number less than or equal to 20. \n(Entering 20 will give you a 20X20 board)\n"
    end

    def ask_for_bomb_count(size)
      puts "Player 1 please enter the number of bombs there should be on the board. \n(The number should not be more than #{(size * size * App::BOMB_PERCENT).to_i})"
    end

    def get_player_entered_board_size
      input = gets.chomp
      if input.match(/^(\d)+$/)
        if input.to_i > 0 && input.to_i <= 20
          puts "You have selected a #{input} X #{input} board. Generating board."
          row_size = input.to_i
        else
          puts "That is not a valid row size. Please try again."
          row_size = nil
        end
      else
        puts "That is not a valid row size. Please try again."
        row_size = nil
      end
      row_size
    end

    def get_player_entered_bomb_count(board_size)
      input = gets.chomp
      if input.match(/^(\d)+$/)
        if input.to_i > 0 && input.to_i <= board_size * App::BOMB_PERCENT
          puts "You selected #{input}. Setting bombs!"
          bomb_count = input.to_i
        else
          puts "That is not a valid bomb count. Please try again."
          bomb_count = nil
        end
      else
        puts "That is not a valid bomb count. Please try again."
        bomb_count = nil
      end
      bomb_count
    end

    def welcome
      puts "\n==========================================="
      puts "           WELCOME TO MINESWEEPER          "
      puts "===========================================\n\n"
    end
  end
end
