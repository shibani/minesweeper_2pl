require "test_helper"

class BoardFormatterTest < Minitest::Test
  def setup
    @game = Minesweeper::Game.new(5,5)
    @board_formatter = @game.board_formatter
  end

  def test_that_it_has_a_message_attribute
    @board_formatter.message = "Hello World"
    out, err = capture_io do
      @board_formatter.print_message(@board_formatter.message)
    end
    assert_equal("Hello World\n", out)
  end

  def test_that_it_can_set_the_show_bombs_attribute
    @board_formatter.show_bombs = true
    refute_nil(@board_formatter.show_bombs)
  end

  def test_that_it_has_a_print_message_method
    assert @board_formatter.respond_to?(:print_message)
  end

  def test_that_can_write_to_the_console
    out, err = capture_io do
      @board_formatter.print_message("welcome to minesweeper\n")
    end
    assert_equal("welcome to minesweeper\n", out)
  end

  def test_that_print_message_can_print_an_emoji
    out, err = capture_io do
      @board_formatter.print_message("welcome to \u{1f4a3}\n")
    end
    assert_equal("welcome to \u{1f4a3}\n", out)
  end

  def test_that_it_returns_a_board_string
    @board_formatter.message="\n   +=====+=====+=====+=====+=====+=====+=====+=====+=====+=====+ "
    assert @board_formatter.message.end_with?("=+ ")
  end

  def test_that_it_can_show_a_user_move
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 8)
    assert_equal("X ", result)
  end

  def test_that_it_can_show_an_empty_cell
    positions = [ "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 6)

    assert_equal("- ", result)
  end

  def test_that_it_can_show_a_cell_value_if_given_an_integer
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 11)

    assert_equal("3 ", result)
  end

  def test_that_it_does_print_zeroes
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 7)

    assert_equal("0 ", result)
  end

  def test_that_it_can_show_a_bomb
    @board_formatter.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 10)

    assert_equal("\u{1f4a3}", result)
  end

  def test_that_it_can_show_bombs_1
    @board_formatter.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "FB", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 5)

    assert_equal("\u{1f4a3}", result)
  end

  def test_that_it_can_show_trophies
    @board_formatter.show_bombs = "won"
    positions = [ "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X"]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 10)

    assert_equal("\u{1f3c6}", result)
  end

  def test_that_it_can_show_flags_1
    positions = [ "B", "2", "0", "X", " ",
                  "BF", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 5)

    assert_equal("\u{1f6a9}", result)
  end

  def test_that_it_can_show_flags_2
    positions = [ "B", "2", "0", "X", " ",
                  "F", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 5)

    assert_equal("\u{1f6a9}", result)
  end

  def test_that_it_can_show_flags_3
    positions = [ "B", "2", "0", "X", " ",
                  "F", "3", "0", "X", " ",
                  "B", "3", "0F", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @game.set_positions(positions)
    board_array = @board_formatter.format_board_with_emoji(@game.board)

    result = @board_formatter.get_cell_content(board_array, 12)

    assert_equal("\u{1f6a9}", result)
  end

  def test_that_it_can_convert_the_board_array_to_show_bomb_emojis
    @board_formatter.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "F", "3", "0", "X", " ",
                  "B", "3", "0F", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    converted_positions = ["\u{1f4a3}", "2 ", "0 ", "X ", "  ",
                  "\u{1f6a9}", "3 ", "0 ", "X ", "  ",
                  "\u{1f4a3}", "3 ", "\u{1f6a9}", "X ", "  ",
                  "\u{1f4a3}", "3 ", "0 ", "X ", "  ",
                  "\u{1f4a3}", "2 ", "0 ", "X ", "  "]
    @game.set_positions(positions)
    result = @board_formatter.format_board_with_emoji(@game.board)
    assert_equal(converted_positions, result)
  end

  def test_that_it_can_convert_the_board_array_to_show_trophy_emojis
    @board_formatter.show_bombs = "won"
    positions = [ "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X"]
    converted_positions = [
                  "\u{1f3c6}", "X ", "X ", "X ", "X ",
                  "\u{1f3c6}", "X ", "X ", "X ", "X ",
                  "\u{1f3c6}", "X ", "X ", "X ", "X ",
                  "\u{1f3c6}", "X ", "X ", "X ", "X ",
                  "\u{1f3c6}", "X ", "X ", "X ", "X "]
    @game.set_positions(positions)
    result = @board_formatter.format_board_with_emoji(@game.board)
    assert_equal(converted_positions, result)
  end

  def test_that_it_can_convert_the_board_array_to_show_a_normal_view
    @board_formatter.show_bombs = nil
    positions = [ "B", "2", "0", "X", " ",
                  "F", "3", "0", "X", " ",
                  "B", "3", "0F", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    converted_positions = ["  ", "2 ", "0 ", "X ", "  ",
                  "\u{1f6a9}", "3 ", "0 ", "X ", "  ",
                  "  ", "3 ", "\u{1f6a9}", "X ", "  ",
                  "  ", "3 ", "0 ", "X ", "  ",
                  "  ", "2 ", "0 ", "X ", "  "]
    @game.set_positions(positions)
    result = @board_formatter.format_board_with_emoji(@game.board)
    assert_equal(converted_positions, result)
  end

end
