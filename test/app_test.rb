require "test_helper"

class AppTest < Minitest::Test
  def setup
    @mock_app = Minesweeper::MockApp.new
    @mock_game = Minesweeper::MockGame.new(5,5)
    @mock_cli = Minesweeper::MockCli.new
  end

  def test_that_it_has_an_app_class
    refute_nil @mock_app
  end

  def test_that_initialize_creates_a_new_cli
    @mock_app.cli.instance_of?(Minesweeper::CLI)
  end

  def test_that_initialize_creates_a_new_cli
    @mock_app.game.instance_of?(Minesweeper::Game)
  end

  def test_that_initialize_can_get_player_input_and_set_the_rows_and_bomb_count
    io = StringIO.new
    io.puts "10"
    io.puts "70"
    io.rewind
    $stdin = io

    @app = Minesweeper::App.new
    $stdin = STDIN

    assert_equal(10, @app.game.row_size)
    assert_equal(70, @app.game.bomb_count)
  end

  def test_play_game_can_check_if_the_game_is_not_over
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", " ", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    refute(@mock_app.game_is_over)
  end

  def test_play_game_runs_the_game_loop_and_places_moves
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "3F", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.cli.reset_count
    @mock_app.cli.set_input!([2,2,"move"], nil)

    @mock_app.play_game

    assert(@mock_app.game_is_over)
  end

  def test_play_game_runs_the_game_loop_and_can_check_if_a_move_is_valid
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "3F", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.cli.reset_count
    @mock_app.cli.set_input!([2,0,"move"], [2,2,"move"])

    out, err = capture_io do
      @mock_app.play_game
    end

    assert_equal("That was not a valid move. Please try again.\n", out)
  end

  def test_play_game_runs_the_game_loop_and_places_moves_till_the_game_is_over
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "3F", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.cli.reset_count
    @mock_app.cli.set_input!([2,1,"move"], [2,2,"move"])

    @mock_app.play_game

    assert_equal("X", @mock_app.game.board.positions[6])
  end

  def test_end_game_can_check_if_the_game_is_won
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.game.game_over = true

    assert_equal("win", @mock_app.game.check_win_or_loss)
  end

  def test_end_game_can_check_if_the_game_is_lost
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "X", "BF", "BF", "B",
                  "X", "X", "X", " ", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.game.game_over = true

    assert_equal("lose", @mock_app.game.check_win_or_loss)
  end

  def test_end_game_can_check_if_game_is_won_and_outputs_a_message_accordingly
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.game.game_over = true

    out, err = capture_io do
      @mock_app.end_game
    end

    assert_equal("Game over! You win!\n", out)
  end

  def test_end_game_can_check_if_game_is_lost_and_outputs_a_message_accordingly
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "X", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @mock_app.game.set_bomb_positions(bomb_positions)
    @mock_app.game.set_positions(positions)
    @mock_app.game.game_over = true

    out, err = capture_io do
      @mock_app.end_game
    end

    assert_equal("Game over! You lose.\n", out)
  end

end
