module Minesweeper_2pl
  class BoardCli

    attr_accessor :message
    attr_accessor :board
    attr_accessor :show_bombs

    NEWLINE = "\n"
    ALPHA_LEFT = "  "
    ALPHA_RIGHT = " "
    CELL_LEFT = "|  "
    CELL_RIGHT = "  "
    CELL_END = "  |"
    CELL_DIVIDER = "+======"
    HEADER_CELL_LEFT = "   "
    HEADER_CELL_RIGHT = "   "
    INTRO = "    "

    def print_message(string)
      puts string
    end

    def set_board(positions, rowsize)
      @board = NEWLINE + INTRO
      rowsize.to_i.times do |count|
        @board += HEADER_CELL_LEFT + count.to_s + HEADER_CELL_RIGHT
      end
      @board += NEWLINE + INTRO
      rowsize.to_i.times do
        @board += CELL_DIVIDER
      end
      @board += "+"
      @board += NEWLINE + ALPHA_LEFT + 0.to_s + ALPHA_RIGHT
      rowsize.to_i.times do |i|
        rowsize.to_i.times do |j|
          if self.show_bombs
            cell_content = positions[i*j] == "B" ? "\u{1f4a3}" : "  "
          else
            cell_content = positions[i*j] == "B" ? "  " : "  "
          end
          if j == rowsize - 1
            @board += CELL_LEFT + cell_content + CELL_END
          else
            @board += CELL_LEFT + cell_content + CELL_RIGHT
          end
        end
        @board += NEWLINE + INTRO
        rowsize.to_i.times do
          @board += CELL_DIVIDER
        end
        @board += "+"
        unless i == rowsize - 1
          @board += NEWLINE + ALPHA_LEFT + (i+1).to_s + ALPHA_RIGHT
        end
      end
    end

  end
end
