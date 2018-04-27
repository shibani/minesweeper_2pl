require "test_helper"

class BoardCliTest < Minitest::Test
  def setup
    @game = Minesweeper::Game.new(5,5)
    @bcli = @game.bcli
  end

  def test_that_it_has_a_message_attribute
    @bcli.message = "Hello World"
    out, err = capture_io do
      @bcli.print_message(@bcli.message)
    end
    assert_equal("Hello World\n", out)
  end

  def test_that_it_can_set_the_show_bombs_attribute
    @bcli.show_bombs = true
    refute_nil(@bcli.show_bombs)
  end

  def test_that_it_has_a_print_message_method
    assert @bcli.respond_to?(:print_message)
  end

  def test_that_can_write_to_the_console
    out, err = capture_io do
      @bcli.print_message("welcome to minesweeper\n")
    end
    assert_equal("welcome to minesweeper\n", out)
  end

  def test_that_print_message_can_print_an_emoji
    out, err = capture_io do
      @bcli.print_message("welcome to \u{1f4a3}\n")
    end
    assert_equal("welcome to \u{1f4a3}\n", out)
  end

  def test_that_it_returns_a_board_string
    @bcli.message="\n   +=====+=====+=====+=====+=====+=====+=====+=====+=====+=====+ "
    assert @bcli.message.end_with?("=+ ")
  end

  def test_that_it_can_show_a_user_move
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 8)
    assert_equal("X ", result)
  end

  def test_that_it_can_show_an_empty_cell
    positions = [ "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " ",
                  "B", "-", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 6)

    assert_equal("- ", result)
  end

  def test_that_it_can_show_a_cell_value_if_given_an_integer
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 11)

    assert_equal("3 ", result)
  end

  def test_that_it_does_print_zeroes
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 7)

    assert_equal("0 ", result)
  end

  def test_that_it_can_show_a_bomb
    @bcli.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 10)

    assert_equal("\u{1f4a3}", result)
  end

  def test_that_it_can_show_bombs_1
    @bcli.show_bombs = "show"
    positions = [ "B", "2", "0", "X", " ",
                  "FB", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 5)

    assert_equal("\u{1f4a3}", result)
  end

  def test_that_it_can_show_trophies
    @bcli.show_bombs = "won"
    positions = [ "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X",
                  "BF", "X", "X", "X", "X"]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 10)

    assert_equal("\u{1f3c6}", result)
  end

  def test_that_it_can_show_flags_1
    positions = [ "B", "2", "0", "X", " ",
                  "BF", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 5)

    assert_equal("\u{1f6a9}", result)
  end

  def test_that_it_can_show_flags_2
    positions = [ "B", "2", "0", "X", " ",
                  "F", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 5)

    assert_equal("\u{1f6a9}", result)
  end

  def test_that_it_can_show_flags_3
    positions = [ "B", "2", "0", "X", " ",
                  "F", "3", "0", "X", " ",
                  "B", "3", "0F", "X", " ",
                  "B", "3", "0", "X", " ",
                  "B", "2", "0", "X", " "]
    @bcli.board_to_string(@game.board)

    result = @bcli.get_cell_content(positions, 12)

    assert_equal("\u{1f6a9}", result)
  end

end
