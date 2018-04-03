require "test_helper"

class BoardTest < Minitest::Test
  def test_that_it_has_a_board_class
    board = Minesweeper_2pl::Board.new
    refute_nil board
  end

  def test_that_it_has_a_size_attribute
    board = Minesweeper_2pl::Board.new
    board.size = 100
    assert_equal(100, board.size)
  end

  def test_that_it_has_bomb_positions_attribute
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 10
    board.set_bombs
    refute_nil board.bomb_positions
  end

  def test_that_it_has_a_bomb_count_attribute
    board = Minesweeper_2pl::Board.new
    board.bomb_count = 90
    assert_equal(90, board.bomb_count)
  end

  def test_that_it_has_a_positions_attribute
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 10
    board.set_positions(100)
    refute_nil board.positions
  end

  def test_that_set_positions_sets_the_row_size
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 10
    board.set_positions(100)
    refute_nil board.row_size
  end

  def test_that_set_positions_sets_the_bombs
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 60
    board.set_positions(100)
    refute_nil board.bomb_positions
  end

  def test_set_row_size
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 10
    board.set_positions(100)
    assert_equal(10, board.row_size)
  end

  def test_that_set_positions_can_set_the_bomb_positions_1
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 60
    board.set_positions(100)
    assert_equal(60, board.bomb_positions.size)
  end

  def test_that_set_positions_can_set_the_bomb_positions_2
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 60
    board.set_positions(100)
    assert_operator(0, :<=, board.bomb_positions.min)
  end

  def test_that_set_positions_can_set_the_bomb_positions_2
    board = Minesweeper_2pl::Board.new
    board.size = 100
    board.bomb_count = 60
    board.set_positions(100)
    assert_operator(60, :<=, board.bomb_positions.max)
  end

end
