module Minesweeper_2pl
  class BoardCli

    attr_accessor :message, :board, :show_bombs

    NEWLINE = "\n"
    ALPHA_LEFT = "  "
    ALPHA_RIGHT = " "
    CELL_LEFT = "|  "
    CELL_RIGHT = "  "
    CELL_END = "  |"
    CELL_DIVIDER = "+======"
    HEADER_CELL_LEFT = "   "
    HEADER_CELL_RIGHT = "  "
    INTRO = "     "

    def print_message(string)
      puts string
    end

    def set_board(positions, rowsize)
      @board = NEWLINE + INTRO
      rowsize.to_i.times do |count|
        @board += HEADER_CELL_LEFT + sprintf("%2s", (count).to_s) + HEADER_CELL_RIGHT
      end
      @board += NEWLINE + INTRO
      rowsize.to_i.times do
        @board += CELL_DIVIDER
      end
      @board += "+"
      @board += NEWLINE + ALPHA_LEFT + sprintf("%2s", 0.to_s) + ALPHA_RIGHT
      (0..rowsize.to_i-1).to_a.each do |i|
        (0..rowsize.to_i-1).to_a.each do |j|
          if j == rowsize - 1
            @board += CELL_LEFT + get_cell_content(positions, (i*rowsize.to_i)+(j)) + CELL_END
          else
            @board += CELL_LEFT + get_cell_content(positions, (i*rowsize.to_i)+(j)) + CELL_RIGHT
          end
        end
        @board += NEWLINE + INTRO
        rowsize.to_i.times do
          @board += CELL_DIVIDER
        end
        @board += "+"
        unless i == rowsize - 1
          @board += NEWLINE + ALPHA_LEFT + sprintf("%2s", (i+1).to_s) + ALPHA_RIGHT
        end
      end
    end

    def get_cell_content(positions, cell)
      if self.show_bombs
        if positions[cell] == "B"
          cell_content = "\u{1f4a3}"
        elsif positions[cell] == "X"
          cell_content = "X "
        else
          cell_content = "  "
        end
      else
        if positions[cell] == "X"
          cell_content = "X "
        elsif positions[cell].is_a? Integer
          if positions[cell] == 0 || positions[cell] > 4
            cell_content = "  "
          else
            cell_content = positions[cell].to_s + " "
          end
        elsif positions[cell] == "-"
          cell_content = "- "
        else
          cell_content = "  "
        end
      end
      cell_content
    end

  end
end
