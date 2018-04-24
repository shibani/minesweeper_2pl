require 'stringio'
require "test_helper"
require "io_test_helpers"

class CliTest < Minitest::Test
  include IoTestHelpers

  def setup
    @cli = Minesweeper::CLI.new
    @mock_game = Minesweeper::MockGame.new(10,0)
    #@mock_game.setup(10, 0)
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

  def test_that_it_asks_for_a_move
    out, err = capture_io do
      @cli.ask_for_move
    end
    assert_equal("\nPlayer 1, make your move:\n- to place a move: enter the word 'move' followed by one digit from the header and one digit from the left column, eg. move 3,1:\n- to place (or remove) a flag: enter the word 'flag' followed by the desired coordinates eg flag 3,1\n", out)
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

  def test_that_it_can_check_if_the_input_is_valid_1
    assert_output "Expecting 'flag' or 'move', with one digit from header and one digit from left column. Please try again!\n" do
      simulate_stdin("bad input") { @cli.get_player_input(@mock_game) }
    end
  end

  def test_that_it_can_check_if_the_input_is_valid_2
    assert_output "Expecting 'flag' or 'move', with one digit from header and one digit from left column. Please try again!\n" do
      simulate_stdin("flag A,8") { @cli.get_player_input(@mock_game) }
    end
  end

  def test_that_it_can_check_if_the_coordinates_are_less_than_the_rowsize
    assert_output "Expecting 'flag' or 'move', with one digit from header and one digit from left column. Please try again!\n" do
      simulate_stdin("3,12") { @cli.get_player_input(@mock_game) }
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

  def test_that_it_can_ask_player_to_set_board_size
    out, err = capture_io do
      @cli.ask_for_board_size
    end
    assert_equal("Player 1 please enter a row size for your board, any number less than or equal to 20. \n(Entering 20 will give you a 20X20 board)\n", out)
  end

  def test_that_it_can_capture_a_board_size_from_the_player
    assert_output "You have selected a 10 x 10 board. Generating board.\n\n" do
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
    assert_output "You selected 75. Setting bombs!\n\n" do
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

  def test_that_the_welcome_method_welcomes_the_user
    out, err = capture_io do
      @cli.welcome
    end
    assert_equal("\n===========================================\n           WELCOME TO MINESWEEPER          \n===========================================\n\n", out)
  end

  def test_that_it_has_a_show_game_lost_message
    out, err = capture_io do
      @cli.show_game_over_message("lose")
    end
    assert_equal("Game over! You lose.\n", out)
  end

  def test_that_it_has_a_show_game_won_message
    out, err = capture_io do
      @cli.show_game_over_message("win")
    end
    assert_equal("Game over! You win!\n", out)
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

end
