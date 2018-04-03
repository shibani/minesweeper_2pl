require "test_helper"

class GameTest < Minitest::Test
  def setup
    @game = Minesweeper_2pl::Game.new
    @board = Minesweeper_2pl::Board.new
    @bcli = Minesweeper_2pl::BoardCli.new
    @game.board = @board
  end
  
  def test_that_it_has_a_game_class
    game = Minesweeper_2pl::Game.new
    refute_nil @game
  end

  def test_that_it_has_a_printBoard_method
    assert @game.respond_to?(:printBoard)
  end

  def test_that_it_has_a_setup_method
    assert @game.respond_to?(:setup)
  end

  def test_that_setup_can_create_a_new_board
    @game.setup(100, 100)
    refute_nil @game.board
  end

  def test_that_setup_can_create_a_new_boardcli
    @game.setup(100, 100)
    refute_nil @game.bcli
  end

  def test_that_setup_can_set_the_board_size
    result = @game.set_board_size(100)
    result = @game.board.size

    assert_equal 100, result
  end

  def test_that_setup_can_set_the_bomb_count
    result = @game.set_bomb_count(60)
    result = @game.board.bomb_count

    assert_equal 60, result
  end

  def test_that_setup_can_set_the_boards_positions
    @game.board.bomb_count = 10
    @game.board.size = 60
    result = @game.set_board_positions(60)

    assert_equal 60, result
  end

  def test_that_it_calls_printBoard
    mocked_method = MiniTest::Mock.new
    @game.stub(:printBoard, mocked_method) do
      @game.printBoard
    end
    mocked_method.verify
  end

  def test_that_printBoard_can_call_the_boardclis_print_message_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:print_message, mocked_method) do
      @game.printBoard
    end
    mocked_method.verify
  end

  def test_that_printBoard_can_call_the_boardclis_print_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:print, mocked_method) do
      @game.printBoard
    end
    mocked_method.verify
  end

  def test_that_printBoard_can_call_the_boardclis_set_board_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:set_board, mocked_method) do
      @game.printBoard
    end
    mocked_method.verify
  end

  def test_that_printBoard_can_call_the_boardclis_show_bombs_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:show_bombs, mocked_method) do
      @game.printBoard
    end
    mocked_method.verify
  end

  def test_that_it_calls_the_games_set_board_size_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.board.stub(:size, mocked_method) do
      @game.set_board_size(75)
    end
    mocked_method.verify
  end

  def test_that_it_calls_the_games_set_bomb_count_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.board.stub(:bomb_count, mocked_method) do
      @game.set_bomb_count(60)
    end
    mocked_method.verify
  end

  def test_that_it_sets_the_games_board_positions
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.board.stub(:set_positions, mocked_method) do
      @game.set_board_positions(100)
    end
    mocked_method.verify
  end

  def test_that_it_gets_the_games_board_positions
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.board.stub(:positions, mocked_method) do
      @game.board_positions
    end
    mocked_method.verify
  end

end
