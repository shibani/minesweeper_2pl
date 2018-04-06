require "test_helper"

class BoardTest < Minitest::Test
  def setup
    @board = Minesweeper_2pl::Board.new
    @board.size = 100
    @board.bomb_count = 10
    @board.set_positions(100)
  end

  def test_that_it_has_a_board_class
    refute_nil @board
  end

  def test_that_it_has_a_size_attribute
    assert_equal(100, @board.size)
  end

  def test_that_it_has_bomb_positions_attribute
    @board.set_bombs
    refute_nil @board.bomb_positions
  end

  def test_that_it_sets_bomb_positions
    @board.set_bombs
    assert_equal(10, @board.bomb_positions.size)
  end

  def test_that_it_has_a_bomb_count_attribute
    assert_equal(10, @board.bomb_count)
  end

  def test_that_it_has_a_positions_attribute
    refute_nil @board.positions
  end

  def test_that_set_positions_sets_the_row_size
    refute_nil @board.row_size
  end

  def test_that_set_positions_sets_the_bombs
    refute_nil @board.bomb_positions
  end

  def test_set_row_size
    assert_equal(10, @board.row_size)
  end

  def test_that_set_positions_can_set_the_bomb_positions_1
    assert_equal(10, @board.bomb_positions.size)
  end

  def test_that_set_positions_can_set_the_bomb_positions_2
    assert_operator(0, :<=, @board.bomb_positions.min)
  end

  def test_that_set_positions_can_set_the_bomb_positions_2
    assert_operator(10, :<=, @board.bomb_positions.max)
  end

  def test_that_set_positions_can_set_the_bomb_positions_4
    counts = Hash.new(0)
    @board.positions.each do |position|
      counts[position] += 1
    end
    assert_equal(10, counts["B"])
  end
end
