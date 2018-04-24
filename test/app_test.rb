require "test_helper"

class AppTest < Minitest::Test
  def setup
    @app = Minesweeper::App.new
    @mock_app = Minesweeper::MockApp.new
    @mock_game = Minesweeper::MockGame.new(100,0)
    @mock_cli = Minesweeper::MockCli.new
    @app.game = @mock_game
    @app.cli = @mock_cli
  end

  def test_that_it_has_an_app_class
    refute_nil @app
  end

  def test_that_it_has_a_cli
    refute_nil @app.cli
  end

  def test_that_it_has_a_start_method
    assert @app.respond_to?(:start)
  end

  def test_that_it_has_a_setup_method
    assert @app.respond_to?(:setup)
  end

  def test_that_it_creates_a_new_game
    refute_nil @app.game
  end

  def test_initialize_creates_a_new_cli
    io = StringIO.new
    io.puts "10"
    io.puts "70"
    io.rewind
    $stdin = io

    $stdin = STDIN

    @mock_app.cli.instance_of?(Minesweeper::CLI)
  end

  def test_setup_calls_clis_get_player_params_method
    mocked_method = MiniTest::Mock.new

    @app.cli.stub(:get_player_params, mocked_method) do
      io = StringIO.new
      io.puts "10"
      io.puts "70"
      io.rewind
      $stdin = io

      @app.setup
      $stdin = STDIN
    end
    mocked_method.verify
  end

  def test_setup_creates_a_new_game
    io = StringIO.new
    io.puts "10"
    io.puts "70"
    io.rewind
    $stdin = io

    @app.setup
    $stdin = STDIN

    assert @app.game.instance_of?(Minesweeper::Game)
  end

  def test_play_game_can_check_if_the_game_is_over
    @app.game.set_row_size(5)
    @app.game.set_bomb_count(5)
    @app.game.board.bomb_positions = [10, 11, 12, 13, 14]
    @app.game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", " ", "X", "X", "X"]
    refute(@app.game_is_over)
  end

  def test_play_game_runs_the_game_loop_1
    @app.game.set_row_size(4)
    @app.game.set_bomb_count(4)
    @app.game.board.bomb_positions = [8, 9, 10, 11]
    @app.game.board.positions = ["X", "X", "X", "X",
                        "X", "X", "3F", "X",
                        "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X",
                        "X", "X", "X", "X"]
    @app.cli.reset_count
    @app.cli.set_input!([2,2,"move"], nil)

    @app.play_game

    assert(@app.game_is_over)
  end

  def test_play_game_runs_the_game_loop_2
    @app.game.set_row_size(4)
    @app.game.set_bomb_count(4)
    @app.game.board.bomb_positions = [8, 9, 10, 11]
    @app.game.board.positions = ["X", "X", "X", "X",
                        "X", "X", "3F", "X",
                        "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X",
                        "X", "X", "X", "X"]
    @app.cli.reset_count
    @app.cli.set_input!([2,1,"move"], [2,2,"move"])

    @app.play_game

    assert_equal("X", @app.game.board.positions[6])
  end

  def test_end_game_calls_the_games_is_won_method_1
    @app.game.set_row_size(5)
    @app.game.set_board_size(5)
    @app.game.set_bomb_count(5)
    @app.game.board.bomb_positions = [10, 11, 12, 13, 14]
    @app.game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X"]
    @app.game.game_over = true

    out, err = capture_io do
      @app.end_game
    end

    assert_equal("Game over! You win!\n", out)
  end

  def test_end_game_calls_the_games_is_won_method_2
    @app.game.set_row_size(5)
    @app.game.set_board_size(5)
    @app.game.set_bomb_count(5)
    @app.game.board.bomb_positions = [10, 11, 12, 13, 14]
    @app.game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X"]
    @app.game.game_over = true

    assert_equal("win", @app.game.check_game_status)
  end

end
