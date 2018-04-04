require "test_helper"

class AppTest < Minitest::Test
  def setup
    @app = Minesweeper_2pl::App.new
    @mocked_app = Minesweeper_2pl::App.new
    @mocked_game = Minesweeper_2pl::MockedGame.new
    @mocked_cli = Minesweeper_2pl::MockedCli.new
    @mocked_app.game = @mocked_game
    @mocked_app.cli = @mocked_cli
  end

  def test_that_it_has_an_app_class
    refute_nil @mocked_app
  end

  def test_that_it_has_a_cli
    refute_nil @mocked_app.cli
  end

  def test_that_it_has_a_start_method
    assert @mocked_app.respond_to?(:start)
  end

  def test_that_it_has_a_setup_method
    assert @mocked_app.respond_to?(:setup)
  end

  def test_that_it_creates_a_new_game
    refute_nil @mocked_app.game
  end

  def test_that_it_calls_the_apps_setup_method
    mocked_method = MiniTest::Mock.new
    @mocked_app.stub(:setup, mocked_method) do
      @mocked_app.stub(:play_game, nil) do
        @mocked_app.start
      end
    end
    mocked_method.verify
  end

  def test_that_it_calls_the_apps_play_game_method
    mocked_method = MiniTest::Mock.new
    @mocked_app.stub(:play_game, mocked_method) do
      @mocked_app.start
    end
    mocked_method.verify
  end

  def test_setup_creates_a_new_cli
    @mocked_app.setup
    assert @mocked_app.cli.instance_of?(Minesweeper_2pl::CLI)
  end

  def test_setup_creates_a_new_game
    @mocked_app.setup
    assert @mocked_app.game.instance_of?(Minesweeper_2pl::Game)
  end

  def test_setup_sets_the_cli
    mocked_method = MiniTest::Mock.new

    @app.stub(:cli, mocked_method) do
      @app.setup
    end
    mocked_method.verify
  end

  def test_setup_sets_the_game
    mocked_method = MiniTest::Mock.new
    mocked_method.expect :setup, nil, [100, 10]

    @app.stub(:game, mocked_method) do
      @app.setup
    end
    mocked_method.verify
  end

  def test_setup_calls_games_setup_method
    mocked_method = MiniTest::Mock.new

    @mocked_app.game.stub(:setup, mocked_method) do
      @mocked_app.setup
    end
    mocked_method.verify
  end

  def test_play_game_calls_games_print_board_method
    mocked_game = MiniTest::Mock.new

    @mocked_app.game.stub(:print_board, mocked_game) do
      @mocked_app.setup
    end
    mocked_game.verify
  end

  def test_play_game_calls_clis_ask_for_move_method
    mocked_cli = MiniTest::Mock.new
    @mocked_app.cli.stub(:ask_for_move, mocked_cli) do
      @mocked_app.setup
    end
    mocked_cli.verify
  end

  def test_play_game_calls_clis_get_player_input_method
    mocked_cli = MiniTest::Mock.new
    @mocked_app.cli.stub(:get_player_input, mocked_cli) do
      @mocked_app.setup
    end
    mocked_cli.verify
  end

  def test_play_game_calls_the_convert_coordinates_method
    mocked_game = MiniTest::Mock.new
    @mocked_app.game.stub(:move_to_coordinates, mocked_game) do
      @mocked_app.setup
    end
    mocked_game.verify
  end
end
