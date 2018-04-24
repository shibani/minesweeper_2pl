module Minesweeper
  class BoardCli

    attr_accessor :message, :show_bombs

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

    def board_to_string(game)
      string = NEWLINE + INTRO
      game.row_size.to_i.times do |count|
        string += HEADER_CELL_LEFT + sprintf("%2s", (count).to_s) + HEADER_CELL_RIGHT
      end
      string += NEWLINE + INTRO
      game.row_size.to_i.times do
        string += CELL_DIVIDER
      end
      string += "+"
      string += NEWLINE + ALPHA_LEFT + sprintf("%2s", 0.to_s) + ALPHA_RIGHT
      (0..game.row_size.to_i-1).to_a.each do |i|
        (0..game.row_size.to_i-1).to_a.each do |j|
          if j == game.row_size - 1
            string += CELL_LEFT + get_cell_content(game.positions, (i*game.row_size.to_i)+(j)) + CELL_END
          else
            string += CELL_LEFT + get_cell_content(game.positions, (i*game.row_size.to_i)+(j)) + CELL_RIGHT
          end
        end
        string += NEWLINE + INTRO
        game.row_size.to_i.times do
          string += CELL_DIVIDER
        end
        string += "+"
        unless i == game.row_size - 1
          string += NEWLINE + ALPHA_LEFT + sprintf("%2s", (i+1).to_s) + ALPHA_RIGHT
        end
      end
      string
    end

    def get_cell_content(positions, cell)
      cell = positions[cell]
      if show_bombs == "show"
        render_lost_view(cell)
      elsif show_bombs == "won"
        render_won_view(cell)
      else
        render_normal_view(cell)
      end
    end

    private

    def render_lost_view(cell)
      if cell_is_a_bomb_or_flag?(cell)
        show_bomb_emoji
      elsif cell_is_a_bomb?(cell)
        show_bomb_emoji
      elsif cell_is_a_flag?(cell)
        show_flag_emoji
      elsif cell.length == 1
        cell + " "
      end
    end

    def render_won_view(cell)
      if cell_is_a_bomb_or_flag?(cell)
        show_trophy_emoji
      elsif cell_is_a_flag?(cell)
        show_flag_emoji
      elsif cell.length == 1
        cell + " "
      end
    end

    def render_normal_view(cell)
      if cell_is_a_flag?(cell)
        show_flag_emoji
      elsif cell_is_a_bomb?(cell)
        show_empty
      elsif cell.length == 1
        cell + " "
      end
    end

    def cell_is_a_bomb?(cell)
      cell.include? "B"
    end

    def cell_is_a_flag?(cell)
      cell.include? "F"
    end

    def cell_is_a_bomb_or_flag?(cell)
      cell.include? "BF"
    end

    def show_bomb_emoji
      "\u{1f4a3}"
    end

    def show_trophy_emoji
      "\u{1f3c6}"
    end

    def show_flag_emoji
      "\u{1f6a9}"
    end

    def show_empty
      "  "
    end

  end
end
