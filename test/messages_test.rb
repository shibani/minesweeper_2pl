require 'stringio'
require "test_helper"
require "io_test_helpers"

class MessagesTest < Minitest::Test
  include IoTestHelpers

  # welcome
  # ask_for_move
  # ask_for_board_size
  # ask_for_bomb_count(size)
  # show_game_over_message(result)

  # private methods
  # invalid_move
  # player_input_success_message(input)
  # invalid_player_input_message
  # row_size_success_message(input)
  # invalid_row_size_message
  # bomb_count_success_message(input)
  # invalid_bomb_count_message

  def setup
    @cli = Minesweeper::Messages
  end

  def test_that_the_welcome_method_welcomes_the_user
    message = @cli.welcome
    string = "\n===========================================\n           WELCOME TO MINESWEEPER\n===========================================\n\n"

    assert_equal(string, message)
  end

  def test_that_it_asks_for_a_move
    out, _err = capture_io do
      @cli.ask_for_move
    end
    assert_equal("\nPlayer 1, make your move:\n- to place a move: enter the word 'move' followed by one digit from the header and one digit from the left column, eg. move 3,1:\n- to place (or remove) a flag: enter the word 'flag' followed by the desired coordinates eg flag 3,1\n", out)
  end

  def test_that_it_can_ask_player_to_set_board_size
    out, _err = capture_io do
      @cli.ask_for_board_size
    end
    assert_equal("Player 1 please enter a row size for your board, any number less than or equal to 20. \n(Entering 20 will give you a 20X20 board)\n", out)
  end

  def test_that_it_can_ask_player_to_set_bomb_count
    out, _err = capture_io do
      @cli.ask_for_bomb_count(10)
    end
    assert_equal("Player 1 please enter the number of bombs there should be on the board. \n(The number should not be more than 75)\n", out)
  end

  def test_that_it_has_a_show_game_lost_message
    message = @cli.show_game_over_message("lose")
    out, _err = capture_io do
      puts message
    end
    assert_equal("Game over! You lose.\n", out)
  end

  def test_that_it_has_a_show_game_won_message
    message = @cli.show_game_over_message("win")
    out, _err = capture_io do
      puts message
    end
    assert_equal("Game over! You win!\n", out)
  end
end
