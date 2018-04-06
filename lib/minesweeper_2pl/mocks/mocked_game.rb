module Minesweeper_2pl
  class MockedGame < Game

    def setup(board_size, bomb_count)
      bcli = BoardCli.new
      board = Board.new

      self.board = board
      self.set_board_size(board_size)
      self.set_bomb_count(bomb_count)
      self.set_board_positions(board_size)
      self.bcli = bcli
    end

    def print_board
    end

  end
end
