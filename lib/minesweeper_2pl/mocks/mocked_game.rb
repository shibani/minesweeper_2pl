module Minesweeper_2pl
  class MockedGame < Game

    attr_accessor :bcli, :board, :game_over

    def setup(row_size, bomb_count)
      bcli = BoardCli.new
      board = Board.new

      self.board = board
      self.set_board_size(row_size)
      self.set_bomb_count(bomb_count)
      self.set_board_positions(row_size)
      self.bcli = bcli
    end

    def print_board
    end

  end
end
