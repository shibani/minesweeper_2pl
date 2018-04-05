module Minesweeper_2pl
  class CLI

    def print(msg)
      puts msg
    end

    def ask_for_move
      string = "\nPlayer 1, enter one digit for the row (from left) and one digit for the column (from top) to make your move, eg. 3,1: "
      self.print(string)
    end

    def get_player_input(game)
      input = gets.chomp
      if input.include? ","
        coords = input.split(",")
        if ((coords[0].match(/^(\d)+$/)) && (coords[1].match(/^(\d)+$/)) && (coords[0].to_i <= game.board.row_size) && (coords[1].to_i <= game.board.row_size))
          puts "You selected #{input}. Placing your move."
          coords = [coords[0].to_i, coords[1].to_i]
        else
          puts "Expecting one digit for the row (from left) and one digit for the column (from top). Please try again!"
          coords = nil
        end
      else
        puts "Expecting one digit for the row (from left) and one digit for the column (from top). Please try again!"
        coords = nil
      end
      coords
    end

    def show_game_over_message
      puts "Game over! You lose."
    end
  end
end
