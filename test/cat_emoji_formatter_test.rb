require "test_helper"

class CatEmojiFormatterTest < Minitest::Test
  def setup
    @game = Minesweeper::Game.new(5,5, true)
    @cat_emoji_formatter = @game.formatter
  end

  def test_that_it_can_set_the_show_bombs_attribute
    @cat_emoji_formatter.show_bombs = true
    refute_nil(@cat_emoji_formatter.show_bombs)
  end

  def test_that_it_returns_an_array
    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)

    assert_instance_of(Array, board_array)
  end

  def test_that_it_can_show_a_user_move
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[8]

    assert_equal("0 ", result)
  end

  def test_that_it_can_show_an_empty_cell
    positions = [ "B", " ", "0", "X", " ",
                  "B", " ", "0", "X", " ",
                  "B", " ", "0", "X", " ",
                  "B", " ", "0", "X", " ",
                  "B", " ", "0", "X", " "]
    @game.set_positions(positions)

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[4]

    assert_equal("  ", result)
  end

  def test_that_it_can_show_a_cell_value_if_given_an_integer
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[11]

    assert_equal("3 ", result)
  end

  def test_that_it_does_print_zeroes
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[7]

    assert_equal("0 ", result)
  end

  def test_that_it_can_show_a_bomb
    @cat_emoji_formatter.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[10]

    assert_equal("\u{1F640}", result)
  end

  def test_that_it_can_show_bombs_1
    @cat_emoji_formatter.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[5]

    assert_equal("\u{1F640}", result)
  end

  def test_that_it_can_show_trophies
    @cat_emoji_formatter.show_bombs = "won"
    positions = [ "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X"]
    @game.set_positions(positions)
    @game.board_positions[0].add_flag
    @game.board_positions[5].add_flag
    @game.board_positions[10].add_flag
    @game.board_positions[15].add_flag
    @game.board_positions[20].add_flag
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[10]

    assert_equal("\u{1F63A}", result)
  end

  def test_that_it_can_show_flags_1
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(5)

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[5]

    assert_equal("\u{1F364}", result)
  end

  def test_that_it_can_show_flags_2
    positions = [ "B", "2", "0", "X", " ",
                  " ", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(5)

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[5]

    assert_equal("\u{1F364}", result)
  end

  def test_that_it_can_show_flags_3
    positions = [ "B", "2", "0", "X", " ",
                  " ", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(5)
    @game.mark_flag_on_board(12)

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[12]

    assert_equal("\u{1F364}", result)
  end

  def test_that_it_can_show_flags_if_the_game_is_lost
    positions = [ "B", "2", "0", "X", " ",
                  " ", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(5)
    @game.mark_flag_on_board(12)
    @cat_emoji_formatter.show_bombs = "show"
    @game.board_positions.each { |cell| cell.update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result1 = board_array[5]
    result2 = board_array[10]

    assert_equal("\u{1F364}", result1)
    assert_equal("\u{1F640}", result2)
  end

  def test_that_it_can_show_guessed_bombs_if_the_game_is_lost
    positions = [ "B", "2", "0", "X", " ",
                  " ", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(0)
    @game.mark_flag_on_board(10)
    @cat_emoji_formatter.show_bombs = "show"
    to_reveal = [0,1,2,3,4,5,6]
    to_reveal.each { |cell| @game.board_positions[cell].update_cell_status }

    board_array = @cat_emoji_formatter.format_board_with_emoji(@game.board)
    result = board_array[10]

    assert_equal('BF', result)
  end

  def test_that_it_can_convert_the_board_array_to_show_bomb_emojis
    @cat_emoji_formatter.show_bombs = "show"
    positions = [ "B", "1", "0", "X", " ",
                  " ", "2", "0", "X", " ",
                  "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " " ]
    converted_positions = ["\u{1F640}", "1 ", "0 ", "0 ", "0 ",
                  "\u{1F364}", "2 ", "0 ", "0 ", "0 ",
                  "\u{1F640}", "2 ", "\u{1F364}", "0 ", "0 ",
                  "\u{1F640}", "3 ", "0 ", "0 ", "0 ",
                  "\u{1F640}", "2 ", "0 ", "0 ", "0 "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(5)
    @game.mark_flag_on_board(12)
    @game.board_positions.each { |cell| cell.update_cell_status }

    result = @cat_emoji_formatter.format_board_with_emoji(@game.board)

    assert_equal(converted_positions, result)
  end

  def test_that_it_can_convert_the_board_array_to_show_trophy_emojis
    @cat_emoji_formatter.show_bombs = "won"
    positions = [ "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X",
                  "B", "X", "X", "X", "X"]
    converted_positions = [
                  "\u{1F63A}", "2 ", "0 ", "0 ", "0 ",
                  "\u{1F63A}", "3 ", "0 ", "0 ", "0 ",
                  "\u{1F63A}", "3 ", "0 ", "0 ", "0 ",
                  "\u{1F63A}", "3 ", "0 ", "0 ", "0 ",
                  "\u{1F63A}", "2 ", "0 ", "0 ", "0 "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(0)
    @game.mark_flag_on_board(5)
    @game.mark_flag_on_board(10)
    @game.mark_flag_on_board(15)
    @game.mark_flag_on_board(20)
    @game.board_positions.each { |cell| cell.update_cell_status }

    result = @cat_emoji_formatter.format_board_with_emoji(@game.board)

    assert_equal(converted_positions, result)
  end

  def test_that_it_can_convert_the_board_array_to_show_a_normal_view
    @cat_emoji_formatter.show_bombs = nil
    positions = [ "B", "1", "0", "X", " ",
                  " ", "2", "0", "X", " ",
                  "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    converted_positions = ["  ", "1 ", "0 ", "0 ", "0 ",
                  "2 ", "2 ", "0 ", "0 ", "0 ",
                  "  ", "2 ", "0 ", "0 ", "0 ",
                  "  ", "3 ", "0 ", "0 ", "0 ",
                  "  ", "2 ", "0 ", "0 ", "0 "]
    @game.set_positions(positions)
    @game.mark_flag_on_board(5)
    @game.mark_flag_on_board(12)
    @game.board_positions.each { |cell| cell.update_cell_status }

    result = @cat_emoji_formatter.format_board_with_emoji(@game.board)

    assert_equal(converted_positions, result)
  end
end
