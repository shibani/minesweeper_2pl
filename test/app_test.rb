require "test_helper"

class AppTest < Minitest::Test

  def test_that_it_has_an_app_class
    app = Minesweeper_2pl::App.new
    refute_nil app
  end

  def test_that_it_has_a_cli
    app = Minesweeper_2pl::App.new
    app.start
    refute_nil app.cli
  end

  def test_that_it_has_a_start_method
    app = Minesweeper_2pl::App.new
    assert app.respond_to?(:start)
  end

  def test_that_it_has_a_setup_method
    app = Minesweeper_2pl::App.new
    assert app.respond_to?(:setup)
  end

  def test_that_it_creates_a_new_game
    app = Minesweeper_2pl::App.new
    app.start
    refute_nil app.game
  end

  def test_that_it_calls_the_apps_setup_method
    app = Minesweeper_2pl::App.new
    game = Minesweeper_2pl::Game.new
    cli = Minesweeper_2pl::CLI.new
    bcli = Minesweeper_2pl::BoardCli.new
    board = Minesweeper_2pl::Board.new
    app.cli = cli
    app.game = game
    app.game.bcli = bcli
    app.game.board = board

    mocked_app = MiniTest::Mock.new

    app.stub(:setup, mocked_app) do
      app.start
    end
    mocked_app.verify
  end

  def test_that_it_calls_the_apps_play_game_method
    app = Minesweeper_2pl::App.new
    game = Minesweeper_2pl::Game.new
    cli = Minesweeper_2pl::CLI.new
    app.cli = cli
    app.game = game

    mocked_app = MiniTest::Mock.new

    app.stub(:play_game, mocked_app) do
      app.start
    end
    mocked_app.verify
  end

  def test_setup_creates_a_new_cli
    app = Minesweeper_2pl::App.new

    app.setup
    assert app.cli.instance_of?(Minesweeper_2pl::CLI)
  end

  def test_setup_creates_a_new_game
    app = Minesweeper_2pl::App.new

    app.setup
    assert app.game.instance_of?(Minesweeper_2pl::Game)
  end

  def test_setup_sets_the_cli
    app = Minesweeper_2pl::App.new

    mocked_method = MiniTest::Mock.new

    app.stub(:cli, mocked_method) do
      app.setup
    end
    mocked_method.verify
  end

  def test_setup_sets_the_game
    app = Minesweeper_2pl::App.new

    mocked_method = MiniTest::Mock.new
    mocked_method.expect :setup, nil, [100, 60]

    app.stub(:game, mocked_method) do
      app.setup
    end
    mocked_method.verify
  end

  def test_setup_calls_games_setup_method
    app = Minesweeper_2pl::App.new
    game = Minesweeper_2pl::Game.new
    app.game = game

    mocked_method = MiniTest::Mock.new

    app.game.stub(:setup, mocked_method) do
      app.setup
    end
    mocked_method.verify
  end

  def test_play_game_calls_games_printboard_method
    app = Minesweeper_2pl::App.new
    game = Minesweeper_2pl::Game.new
    app.setup

    mocked_method = MiniTest::Mock.new

    app.game.stub(:printBoard, mocked_method) do
      app.play_game
    end
    mocked_method.verify
  end

end
