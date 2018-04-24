module Minesweeper
  class MockGame < Game

    attr_accessor :bcli, :board, :game_over

    def set_input!(input)
      @input = input
    end

    def print_board
      @input
    end

  end
end
