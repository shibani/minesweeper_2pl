module Minesweeper_2pl
  class CLI

    def print(msg)
      puts msg
    end

    def ask_for_move
      string = "\nPlayer 1, enter one digit for the row and one digit for the column to make your move, eg. 3,1: "
      self.print(string)
    end

    def get_player_input
      input = gets.chomp
      if input.include? ","
        coords = input.split(",")
        if (coords[0].match(/^(\d)+$/)) && (coords[1].match(/^(\d)+$/))
          puts "You selected #{input}. Placing your move."
          coords = [coords[0].to_i, coords[1].to_i]
        else
          puts "Please try again!"
          coords = nil
        end
      else
        puts "Please try again!"
        coords = nil
      end
      coords
    end

  end
end
