require "test_helper"

class BoardTest < Minitest::Test
  def test_that_it_has_a_board_class
    board = Minesweeper_2pl::Board.new
    refute_nil board
  end

end
