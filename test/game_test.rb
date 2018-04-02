require "test_helper"

class GameTest < Minitest::Test

  def test_that_it_has_a_game_class
    game = Minesweeper_2pl::Game.new
    refute_nil game
  end

  def test_that_it_has_a_cli
    game = Minesweeper_2pl::Game.new
    cli = Minesweeper_2pl::CLI.new
    game.cli = cli
    refute_nil game.cli
  end

  def test_that_it_has_a_board
    game = Minesweeper_2pl::Game.new
    board = Minesweeper_2pl::Board.new
    game.board = board
    refute_nil game.board
  end

  def test_that_it_has_a_printBoard_method
    game = Minesweeper_2pl::Game.new
    assert game.respond_to?(:printBoard)
  end

  def test_that_it_has_a_setup_method
    game = Minesweeper_2pl::Game.new
    assert game.respond_to?(:setup)
  end

  def test_that_it_calls_cli_methods
    mocked_method = MiniTest::Mock.new
    mocked_method.expect :call, nil, []
    game = Minesweeper_2pl::Game.new
    game.stub(:printBoard, mocked_method) do
      game.printBoard
    end
    mocked_method.verify
  end

  def test_that_it_calls_the_clis_print_method
    game = Minesweeper_2pl::Game.new
    board = Minesweeper_2pl::Board.new
    cli = Minesweeper_2pl::CLI.new
    game.cli = cli
    game.board = board

    mocked_method = MiniTest::Mock.new
    mocked_method.expect :call, nil, [board]

    game.cli.stub(:print, mocked_method) do
      game.printBoard
    end
    mocked_method.verify
  end

end
