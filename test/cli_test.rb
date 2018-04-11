require 'stringio'
require "test_helper"
require "io_test_helpers"

class CliTest < Minitest::Test
  include IoTestHelpers

  def setup
    @cli = Minesweeper_2pl::CLI.new
    @mocked_game = Minesweeper_2pl::MockedGame.new
    @mocked_game.setup(10, 10)
    @mock_cli = Minesweeper_2pl::MockedCli.new
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

  def test_that_it_can_check_if_the_input_is_valid_1
    assert_output "Expecting one digit for the row (from left) and one digit for the column (from top). Please try again!\n" do
      simulate_stdin("A,8") { @cli.get_player_input(@mocked_game) }
    end
  end

  def test_that_it_can_check_if_the_input_is_valid_2
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
    io.puts "5,6"
    io.rewind
    $stdin = io

    result = @cli.get_player_input(@mocked_game)
    $stdin = STDIN

    assert_equal([5,6], result)
  end

  def test_that_it_has_a_show_game_over_message
    out, err = capture_io do
      @cli.show_game_over_message
    end
    assert_equal("Game over! You lose.\n", out)
  end

  def test_that_it_can_ask_player_to_set_board_size
    out, err = capture_io do
      @cli.ask_for_board_size
    end
    assert_equal("Player 1 please enter a row size for your board, any number less than or equal to 20. \n(Entering 20 will give you a 20X20 board)\n", out)
  end

  def test_that_it_can_capture_a_board_size_from_the_player
    assert_output "You have selected a 10 X 10 board. Generating board.\n" do
      simulate_stdin("10") { @cli.get_player_entered_board_size }
    end
  end

  def test_that_it_can_check_if_entered_board_size_is_not_an_integer
    assert_output "That is not a valid row size. Please try again.\n" do
      simulate_stdin("test") { @cli.get_player_entered_board_size }
    end
  end

  def test_that_it_can_check_if_entered_board_size_is_too_large
    assert_output "That is not a valid row size. Please try again.\n" do
      simulate_stdin("35") { @cli.get_player_entered_board_size }
    end
  end

  def test_that_it_returns_the_bomb_count_if_valid
    io = StringIO.new
    io.puts "16"
    io.rewind
    $stdin = io

    result = @cli.get_player_entered_board_size
    $stdin = STDIN

    assert_equal(16, result)
  end

  def test_that_it_can_ask_player_to_set_bomb_count
    out, err = capture_io do
      @cli.ask_for_bomb_count(10)
    end
    assert_equal("Player 1 please enter the number of bombs there should be on the board. \n(The number should not be more than 75)\n", out)
  end

  def test_that_it_can_capture_a_bomb_count_from_the_player
    assert_output "You selected 75. Setting bombs!\n" do
      simulate_stdin("75") { @cli.get_player_entered_bomb_count(100) }
    end
  end

  def test_that_it_can_check_if_entered_bomb_count_is_not_an_integer
    assert_output "That is not a valid bomb count. Please try again.\n" do
      simulate_stdin("test") { @cli.get_player_entered_bomb_count(100) }
    end
  end

  def test_that_it_can_check_if_entered_bomb_count_is_too_large
    assert_output "That is not a valid bomb count. Please try again.\n" do
      simulate_stdin("105") { @cli.get_player_entered_bomb_count(100) }
    end
  end

  def test_that_it_returns_the_bomb_count_if_valid
    io = StringIO.new
    io.puts "70"
    io.rewind
    $stdin = io

    result = @cli.get_player_entered_bomb_count(100)
    $stdin = STDIN

    assert_equal(70, result)
  end

  def test_that_it_can_set_the_board_size_and_bomb_count
    io = StringIO.new
    io.puts "10"
    io.puts "70"
    io.rewind
    $stdin = io

    result = @mock_cli.get_player_params
    $stdin = STDIN

    assert_equal([10,70], result)
  end

  def test_that_the_welcome_method_welcomes_the_user
    out, err = capture_io do
      @cli.welcome
    end
    assert_equal("WELCOME TO MINESWEEPER\n", out)
  end

end
