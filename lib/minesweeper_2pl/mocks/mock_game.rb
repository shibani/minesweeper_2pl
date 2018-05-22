module Minesweeper
  class MockGame < Game

    attr_accessor :board, :board_formatter, :game_over

    def set_input!(input)
      @input = input
    end

    def print_board
      print @input
    end

    def mark_flag_on_board(position)
      mark_flag(position)
    end

    def mark_flag(position)
      board_positions[position].update_flag unless board_positions[position].content == 'X'
    end

  end
end
