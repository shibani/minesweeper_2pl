require 'stringio'
require "test_helper"
require "io_test_helpers"

class CliTest < Minitest::Test
  include IoTestHelpers

  def setup
    @cli = Minesweeper_2pl::CLI.new
    @mocked_game = Minesweeper_2pl::MockedGame.new
    @mocked_game.setup(100, 10)
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
    assert_equal("\nPlayer 1, enter one digit for the row (from left) and one digit for the column (from top) to make your move, eg. 3,1: \n", out)
  end

  def test_that_it_can_capture_input_from_the_player
    assert_output "You selected 3,9. Placing your move.\n" do
      simulate_stdin("3,9") { @cli.get_player_input(@mocked_game) }
    end
  end

  def test_that_it_can_check_if_the_input_is_valid
    assert_output "Expecting one digit for the row (from left) and one digit for the column (from top). Please try again!\n" do
      simulate_stdin("A,8") { @cli.get_player_input(@mocked_game) }
    end
  end

  def test_that_it_can_check_if_the_input_is_valid
    assert_output "Expecting one digit for the row (from left) and one digit for the column (from top). Please try again!\n" do
      simulate_stdin("bad input") { @cli.get_player_input(@mocked_game) }
    end
  end

  def test_that_it_can_check_if_the_coordinates_are_less_than_the_rowsize
    assert_output "Expecting one digit for the row (from left) and one digit for the column (from top). Please try again!\n" do
      simulate_stdin("3,12") { @cli.get_player_input(@mocked_game) }
    end
  end

  def test_that_it_returns_an_array_if_input_is_valid
    io = StringIO.new
    io.puts "3,3"
    io.rewind
    $stdin = io

    result = @cli.get_player_input(@mocked_game)
    $stdin = STDIN

    assert_equal([3,3], result)
  end

  def test_that_it_has_a_show_game_over_message
    out, err = capture_io do
      @cli.show_game_over_message
    end
    assert_equal("Game over! You lose.\n", out)
  end

end
