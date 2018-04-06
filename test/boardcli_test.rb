require "test_helper"

class BoardCliTest < Minitest::Test
  def setup
    @bcli = Minesweeper_2pl::BoardCli.new
  end

  def test_that_it_has_a_message_attribute
    @bcli.message = "Hello World"
    out, err = capture_io do
      @bcli.print_message(@bcli.message)
    end
    assert_equal("Hello World\n", out)
  end

  def test_that_it_has_a_board_attribute
    @bcli.board = "\n    +=====+=====+=====+=====+=====+=====+=====+=====+=====+=====+ "
    out, err = capture_io do
      @bcli.print_message(@bcli.board)
    end
    assert_equal("\n    +=====+=====+=====+=====+=====+=====+=====+=====+=====+=====+ \n", out)
  end

  def test_that_it_has_a_show_bombs_attribute
    @bcli.show_bombs = true
    refute_nil(@bcli.show_bombs)
  end

  def test_that_it_can_set_the_board
    @bcli.set_board(100, 10)
    assert @bcli.board.end_with?('===+')
  end

  def test_that_it_has_a_print_message_method
    assert @bcli.respond_to?(:print_message)
  end

  def test_that__can_write_to_the_console
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

end
