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

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_1
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 21
    result = @board.neighboring_cells(position)
    assert_equal([20, 22, 10, 11, 12, 30, 31, 32], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_bottom_bounds
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 1
    result = @board.neighboring_cells(position)
    assert_equal([0, 2, 10, 11, 12], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_top_bounds
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 98
    result = @board.neighboring_cells(position)
    assert_equal([97, 99, 87, 88, 89], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_left_bounds
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 60
    result = @board.neighboring_cells(position)
    assert_equal([61, 50, 51, 70, 71], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_right_bounds
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 59
    result = @board.neighboring_cells(position)
    assert_equal([58, 48, 49, 68, 69], result)
  end

  def test_that_it_can_check_adjacent_squares_on_the_board
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 21
    result = @board.assign_value(position)
    assert_equal 7, result
  end

  def test_that_it_can_collect_all_adjacent_empty_positions_1
    @board.bomb_count = 13
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 21
    result = @board.adjacent_empties(position)
    assert_equal 1, result.size
  end

  def test_that_it_can_collect_all_adjacent_empty_positions_2
    @board.bomb_count = 11
    @board.bomb_positions = [10, 12, 13, 14, 20, 23, 24, 30, 32, 33, 34]
    @board.set_board_positions(100)
    position = 21
    result = @board.adjacent_empties(position)
    assert_equal 3, result.size
  end

  def test_that_it_can_assign_a_value_to_a_position_on_the_board
    @board.bomb_count = 14
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 21, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 22
    result = @board.assign_value(position)
    assert_equal 8, result
  end

  def test_that_it_can_check_if_a_position_is_empty
    @board.bomb_count = 14
    @board.bomb_positions = [10, 11, 12, 13, 14, 20, 21, 23, 24, 30, 31, 32, 33, 34]
    @board.set_board_positions(100)
    position = 64
    result = @board.is_empty?(position)
    assert result
  end
end
