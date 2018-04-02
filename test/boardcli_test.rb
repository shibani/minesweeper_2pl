require "test_helper"

class BoardCliTest < Minitest::Test

  def test_that_it_has_a_print_method
    bcli = Minesweeper_2pl::BoardCli.new
    assert bcli.respond_to?(:print)
  end

  def test_that_it_can_write_to_the_console
    bcli = Minesweeper_2pl::BoardCli.new
    out, err = capture_io do
      bcli.print("welcome to minesweeper\n")
    end
    assert_equal("welcome to minesweeper\n", out)
  end

  def test_that_it_can_print_an_emoji
    bcli = Minesweeper_2pl::BoardCli.new
    out, err = capture_io do
      bcli.print("welcome to \u{1f4a3}\n")
    end
    assert_equal("welcome to \u{1f4a3}\n", out)
  end

end
