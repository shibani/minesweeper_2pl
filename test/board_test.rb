require "test_helper"

class BoardTest < Minitest::Test
  def test_that_it_has_a_board_class
    board = Minesweeper_2pl::Board.new
    refute_nil board
  end

  def test_that_it_has_a_size_attribute
    board = Minesweeper_2pl::Board.new
    board.size = 100
    refute_nil board.size
  end

  def test_that_it_has_mines
    board = Minesweeper_2pl::Board.new
    board.mines = 10
    refute_nil board.mines
  end

end
