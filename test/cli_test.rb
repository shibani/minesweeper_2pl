require 'stringio'
require "test_helper"
require "io_test_helpers"

class CliTest < Minitest::Test
  include IoTestHelpers

  def setup
    @cli = Minesweeper::CLI.new
    @mock_game = Minesweeper::MockGame.new(10,0)
    @mock_cli = Minesweeper::MockCli.new
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

  def test_that_it_can_capture_input_from_the_player_1
    assert_output "You selected move 3,9. Placing your move.\n" do
      simulate_stdin("move 3,9") { @cli.get_player_input(@mock_game) }
    end
  end

  def test_that_it_can_capture_input_from_the_player_2
    assert_output "You selected flag 9,0. Placing your flag.\n" do
      simulate_stdin("flag 9,0") { @cli.get_player_input(@mock_game) }
    end
  end

  def test_that_it_returns_an_array_if_input_is_valid
    io = StringIO.new
    io.puts "flag 5,6"
    io.rewind
    $stdin = io

    result = @cli.get_player_input(@mock_game)
    $stdin = STDIN

    assert_equal([5,6, "flag"], result)
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

  def test_that_it_can_capture_a_bomb_count_from_the_player
    assert_output "You selected 75. Setting bombs!\n\n" do
      simulate_stdin("75") { @cli.get_player_entered_bomb_count(100) }
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

  def test_that_it_can_get_and_set_the_board_size_and_bomb_count
    io = StringIO.new
    io.puts "10"
    io.puts "70"
    io.rewind
    $stdin = io

    result = @mock_cli.get_player_params
    $stdin = STDIN

    assert_equal([10,70], result)
  end

  def test_that_it_can_call_the_clis_start_methods
    io = StringIO.new
    io.puts "10"
    io.puts "70"
    io.rewind
    $stdin = io

    result = @mock_cli.start
    $stdin = STDIN

    assert_equal([10,70], result)
  end

  def test_that_it_can_get_a_player_move
    io = StringIO.new
    io.puts "move 5,6"
    io.rewind
    $stdin = io

    result = @cli.get_move(@mock_game)
    $stdin = STDIN

    assert_equal([5,6, "move"], result)
  end

  def test_that_it_can_return_a_string_if_invalid_move
    string = puts "That was not a valid move. Please try again."
    assert_equal(@cli.invalid_move, string)
  end

  def test_that_it_can_return_the_game_over_message
    string = "Game over! You win!"
    assert_equal(@cli.show_game_over_message("win"), string)
  end
end
