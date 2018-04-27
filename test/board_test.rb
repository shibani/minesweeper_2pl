require "test_helper"

class BoardTest < Minitest::Test
  def setup
    @board = Minesweeper::Board.new(10, 10)
    @board.set_positions(100)

    @board08 = Minesweeper::Board.new(10, 8)
    @board11 = Minesweeper::Board.new(10, 11)
    @board12 = Minesweeper::Board.new(10, 12)
    @board13 = Minesweeper::Board.new(10, 13)
    @board14 = Minesweeper::Board.new(10, 14)
  end

  def test_that_it_has_a_board_class
    refute_nil @board
  end

  def test_that_it_initializes_with_a_row_size
    assert_equal 10, @board.row_size
  end

  def test_that_it_initializes_with_a_bomb_count
    assert_equal 10, @board.bomb_count
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

  def test_that_it_can_collect_neighboring_cells_when_given_a_position
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 21
    result = @board13.neighboring_cells(position)
    assert_equal([20, 22, 10, 11, 12, 30, 31, 32], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_bottom_bounds
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 1
    result = @board13.neighboring_cells(position)
    assert_equal([0, 2, 10, 11, 12], result)
  end

  def test_that_it_can_collect_neighboring_empty_cells_when_given_a_position
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 21
    result = @board13.neighboring_cells(position, true)
    assert_equal([22], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_top_bounds
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 98
    result = @board13.neighboring_cells(position)
    assert_equal([97, 99, 87, 88, 89], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_left_bounds
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 60
    result = @board13.neighboring_cells(position)
    assert_equal([61, 50, 51, 70, 71], result)
  end

  def test_that_it_can_collect_neighboring_cells_when_given_a_position_close_to_right_bounds
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 59
    result = @board13.neighboring_cells(position)
    assert_equal([58, 48, 49, 68, 69], result)
  end

  def test_that_it_can_check_adjacent_squares_on_the_board_for_positions_bomb_value
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 21
    result = @board13.assign_value(position)
    assert_equal 7, result
  end

  def test_that_it_can_assign_a_value_to_a_position_on_the_board
    @board14.bomb_positions = [10, 11, 12, 13, 14, 20, 21, 23, 24, 30, 31, 32, 33, 34]
    @board14.set_board_positions(100)
    position = 22
    result = @board14.assign_value(position)
    assert_equal 8, result
  end

  def test_that_it_can_check_if_a_position_is_empty_1
    @board14.bomb_positions = [10, 11, 12, 13, 14, 20, 21, 23, 24, 30, 31, 32, 33, 34]
    @board14.set_board_positions(100)
    position = 64

    result = @board14.is_empty?(position)

    assert result
  end

  def test_that_it_can_check_if_a_position_is_empty_2
    @board11.bomb_positions = [10, 12, 13, 14, 20, 23, 24, 30, 32, 33, 34]
    @board11.set_board_positions(100)
    position = 64
    @board11.positions[position] = "3F"

    result = @board11.is_empty?(position)

    assert(result)
  end

  def test_that_it_can_collect_all_adjacent_empty_positions_1
    @board13.bomb_positions = [10, 11, 12, 13, 14, 20, 23, 24, 30, 31, 32, 33, 34]
    @board13.set_board_positions(100)
    position = 21
    result = @board13.neighboring_cells(position, true)
    assert_equal 1, result.size
  end

  def test_that_it_can_collect_all_adjacent_empty_positions_2
    @board11.bomb_positions = [10, 12, 13, 14, 20, 23, 24, 30, 32, 33, 34]
    @board11.set_board_positions(100)
    position = 21
    result = @board11.neighboring_cells(position, true)
    assert_equal 3, result.size
  end

  def test_that_it_can_clear_adjacent_spaces
    @board08.bomb_positions = [10, 11, 12, 20, 22, 30, 31, 32]
    @board08.set_board_positions(100)
    position = 21
    result = @board08.spaces_to_clear(position)
    assert_equal([], result)
  end

  def test_that_it_can_clear_adjacent_spaces_1
    @board.bomb_positions = [10, 11, 12, 20, 22, 30, 32, 40, 41, 42]
    @board.set_board_positions(100)
    position = 21
    result = @board.spaces_to_clear(position)
    assert_equal([31], result)
  end

  def test_that_it_can_clear_adjacent_spaces_2
    @board12.bomb_positions = [10, 11, 12, 13, 20, 23, 30, 33, 40, 41, 42, 43]
    @board12.set_board_positions(100)
    position = 21
    result = @board12.spaces_to_clear(position)
    assert_equal([22, 31, 32], result)
  end

  def test_that_it_can_clear_adjacent_spaces_3
    @board12.bomb_positions = [10, 11, 12, 13, 14, 20, 24, 30, 34, 40, 41, 42, 43, 44]
    @board12.set_board_positions(100)
    position = 21
    result = @board12.spaces_to_clear(position)
    assert_equal([22, 31, 32, 23, 33], result)
  end

  def test_that_it_can_clear_adjacent_spaces_3
    @board12.bomb_positions = [10, 11, 12, 13, 14, 15, 20, 25, 30, 35, 40, 41, 42, 43, 44, 45]
    @board12.set_board_positions(100)
    position = 21
    result = @board12.spaces_to_clear(position)
    assert_equal([22, 31, 32, 23, 33, 24, 34], result)
  end

  def test_that_it_can_set_empties_in_the_positions_array
    @board12.bomb_positions = [10, 11, 12, 13, 14, 15, 20, 25, 30, 35, 40, 41, 42, 43, 44, 45]
    @board12.set_board_positions(100)
    position = 21
    result = @board12.spaces_to_clear(position)
    @board12.show_adjacent_empties(position)
    assert_equal("-", @board12.positions[result.last])
  end

  def test_that_it_can_assign_values_to_empties_in_the_positions_array
    @board12.bomb_positions = [10, 11, 12, 13, 14, 15, 20, 25, 30, 35, 40, 41, 42, 43, 44, 45]
    @board12.set_board_positions(100)
    position = 21
    result = @board12.spaces_to_clear(position)
    @board12.show_adjacent_empties_with_value(position)
    assert_kind_of(String, @board12.positions[result.last])
  end
end
