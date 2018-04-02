require "test_helper"

class GameTest < Minitest::Test

  def test_that_it_has_a_game_class
    game = Minesweeper_2pl::Game.new
    refute_nil game
  end

  def test_that_it_has_a_printBoard_method
    game = Minesweeper_2pl::Game.new
    assert game.respond_to?(:printBoard)
  end

  def test_that_it_has_a_setup_method
    game = Minesweeper_2pl::Game.new
    assert game.respond_to?(:setup)
  end

  def test_that_setup_can_create_a_new_board
    game = Minesweeper_2pl::Game.new

    game.setup(100)
    refute_nil game.board
  end

  def test_that_setup_can_create_a_new_boardcli
    game = Minesweeper_2pl::Game.new

    game.setup(100)
    refute_nil game.bcli
  end

  def test_that_setup_can_set_the_board_size
    game = Minesweeper_2pl::Game.new

    game.setup(100)
    result = game.board.size

    assert_equal 100, result
  end

  def test_that_it_calls_printBoard
    mocked_method = MiniTest::Mock.new
    
    game = Minesweeper_2pl::Game.new
    game.stub(:printBoard, mocked_method) do
      game.printBoard
    end
    mocked_method.verify
  end

  def test_that_printBoard_can_call_the_boardclis_print_method
    game = Minesweeper_2pl::Game.new
    board = Minesweeper_2pl::Board.new
    bcli = Minesweeper_2pl::BoardCli.new
    game.bcli = bcli
    game.board = board

    mocked_method = MiniTest::Mock.new

    game.bcli.stub(:print, mocked_method) do
      game.printBoard
    end
    mocked_method.verify
  end

end
