module Minesweeper
  class BoardFormatter

    attr_accessor :message, :show_bombs

    NEWLINE = "\n"
    ALPHA_LEFT = '  '
    ALPHA_RIGHT = ' '
    CELL_LEFT = '|  '
    CELL_RIGHT = '  '
    CELL_END = '  |'
    CELL_DIVIDER = '+======'
    HEADER_CELL_LEFT = '   '
    HEADER_CELL_RIGHT = '  '
    INTRO = '     '

    def print_message(string)
      puts string
    end

    def format_board_with_emoji(board)
      board.positions.map do |cell|
        if show_bombs == 'show'
          render_lost_view(cell)
        elsif show_bombs == 'won'
          render_won_view(cell)
        else
          render_normal_view(cell)
        end
      end
    end

    def board_to_string(board_array, board)
      string = build_header(board)
      string += header_formatting
      string += build_rows(board_array, board)
    end

    def header_formatting
      NEWLINE + ALPHA_LEFT + sprintf('%2s', 0.to_s) + ALPHA_RIGHT
    end

    def build_header(board)
      string = NEWLINE + INTRO
      board.row_size.to_i.times do |count|
        string += HEADER_CELL_LEFT + sprintf('%2s', (count).to_s) + HEADER_CELL_RIGHT
      end
      string += NEWLINE + INTRO
      board.row_size.to_i.times do
        string += CELL_DIVIDER
      end
      string += '+'
    end

    def build_rows(board_array, board)
      string = ''
      (0..board.row_size.to_i-1).to_a.each do |row|
        string += build_cell(board_array, row, board)
        string += build_row_divider(board, row)
      end
      string
    end

    def build_cell(board_array, row, board)
      string = ''
      (0..board.row_size.to_i-1).to_a.each do |col|
        if col == board.row_size - 1
          string += CELL_LEFT + get_cell_content(board_array, (row*board.row_size.to_i)+(col)) + CELL_END
        else
          string += CELL_LEFT + get_cell_content(board_array, (row*board.row_size.to_i)+(col)) + CELL_RIGHT
        end
      end
      string
    end

    def build_row_divider(board, row)
      string = NEWLINE + INTRO
      board.row_size.to_i.times do
        string += CELL_DIVIDER
      end
      string += '+'
      unless row == board.row_size - 1
        string += NEWLINE + ALPHA_LEFT + sprintf('%2s', (row+1).to_s) + ALPHA_RIGHT
      end
      string
    end

    def get_cell_content(cells, position)
      cells[position]
    end

    private

    def render_lost_view(cell)
      if cell_is_revealed?(cell)
        if cell_is_a_bomb?(cell)
          show_bomb_emoji
        elsif cell_is_a_flag?(cell)
          show_flag_emoji
        elsif cell.content == 'X'
          show_cell_value(cell)
        elsif cell.value.is_a? Integer
          show_cell_value(cell)
        end
      else
        if cell_is_a_bomb?(cell)
          show_bomb_emoji
        else
          show_empty
        end
      end
    end

    def render_won_view(cell)
      if cell_is_a_bomb?(cell)
        show_trophy_emoji
      elsif cell_is_a_flag?(cell)
        show_flag_emoji
      elsif cell.content == 'X'
        show_cell_value(cell)
      elsif cell.value.is_a? Integer
        show_cell_value(cell)
      end
    end

    def render_normal_view(cell)
      if cell_is_revealed?(cell)
        if cell.content == 'X'
          show_cell_value(cell)
        elsif cell_is_a_flag?(cell)
          show_flag_emoji
        elsif cell_is_a_bomb?(cell)
          show_empty
        elsif cell.value.is_a? Integer
          show_cell_value(cell)
        end
      else
        if cell_is_a_flag?(cell)
          show_flag_emoji
        else
          show_empty
        end
      end
    end

    def cell_is_revealed?(cell)
      cell.status == 'revealed'
    end

    def cell_is_a_bomb?(cell)
      cell.content == 'B'
    end

    def cell_is_a_flag?(cell)
      cell.flag == 'F'
    end

    def cell_is_a_bomb_or_flag?(cell)
      cell.content == 'B' || cell.flag == 'F'
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

    def show_user_move
      "X "
    end

    def show_cell_value(cell)
      cell.value.to_s + ' '
    end

    def show_empty
      '  '
    end
  end
end
