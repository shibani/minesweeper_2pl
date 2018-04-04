require "test_helper"
require "io_test_helpers"

class CliTest < Minitest::Test
  include IoTestHelpers

  def setup
    @cli = Minesweeper_2pl::CLI.new
  end

  def test_that_it_has_a_cli_class
    refute_nil @cli
  end

  def test_that_it_can_write_to_the_console
    out, err = capture_io do
      @cli.print("welcome to minesweeper\n")
    end
    assert_equal("welcome to minesweeper\n", out)
  end

  def test_that_it_has_a_print_method
    assert @cli.respond_to?(:print)
  end

  def test_that_it_asks_for_a_move
    out, err = capture_io do
      @cli.ask_for_move
    end
    assert_equal("\nPlayer 1, enter one digit for the row and one digit for the column to make your move, eg. 3,1: \n", out)
  end

  def test_that_it_can_capture_input_from_the_player
    assert_output "You selected 1,1. Placing your move.\n" do
      simulate_stdin("1,1") { @cli.get_player_input }
    end
  end

  def test_that_it_can_check_if_the_input_is_valid
    assert_output "Please try again!\n" do
      simulate_stdin("A,8") { @cli.get_player_input }
    end
  end

  def test_that_it_can_check_if_the_input_is_valid
    assert_output "Please try again!\n" do
      simulate_stdin("bad input") { @cli.get_player_input }
    end
  end

end
