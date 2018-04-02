require "test_helper"

class AppTest < Minitest::Test

  def test_that_it_has_an_app_class
    app = Minesweeper_2pl::App.new
    refute_nil app
  end

  def test_that_it_has_a_game
    app = Minesweeper_2pl::App.new
    game = Minesweeper_2pl::Game.new
    app.game = game
    refute_nil app.game
  end

  def test_that_it_has_a_cli
    app = Minesweeper_2pl::App.new
    cli = Minesweeper_2pl::CLI.new
    app.cli = cli
    refute_nil app.cli
  end

  def test_that_it_has_a_call_method
    app = Minesweeper_2pl::App.new
    assert app.respond_to?(:call)
  end

  def test_that_it_calls_the_games_setup_method
    app = Minesweeper_2pl::App.new
    game = Minesweeper_2pl::Game.new
    cli = Minesweeper_2pl::CLI.new
    app.game = game
    app.cli = cli

    mocked_method = MiniTest::Mock.new
    mocked_method.expect :call, nil, []

    app.game.stub(:setup, mocked_method) do
      app.call
    end
    mocked_method.verify
  end

end
