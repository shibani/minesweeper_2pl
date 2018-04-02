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

    mocked_app = MiniTest::Mock.new

    app.stub(:setup, mocked_app) do
      app.start
    end
    mocked_app.verify
  end

  def test_start_sets_the_cli
    app = Minesweeper_2pl::App.new

    mocked_method = MiniTest::Mock.new

    app.stub(:cli, mocked_method) do
      app.start
    end
    mocked_method.verify
  end

  def test_start_sets_the_game
    app = Minesweeper_2pl::App.new

    mocked_method = MiniTest::Mock.new
    mocked_method.expect :setup, nil, [100]

    app.stub(:game, mocked_method) do
      app.start
    end
    mocked_method.verify
  end

  def test_start_calls_apps_setup_method
    app = Minesweeper_2pl::App.new

    mocked_method = MiniTest::Mock.new

    app.stub(:setup, mocked_method) do
      app.start
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

end
