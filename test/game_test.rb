require "test_helper"

class GameTest < Minitest::Test
  def setup
    @game = Minesweeper_2pl::Game.new
    @board = Minesweeper_2pl::Board.new
    @bcli = Minesweeper_2pl::BoardCli.new
    @game.setup(100,100)
  end

  def test_that_it_has_a_game_class
    refute_nil @game
  end

  def test_that_it_has_a_print_board_method
    assert @game.respond_to?(:print_board)
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

  def test_that_it_calls_print_board
    mocked_method = MiniTest::Mock.new
    @game.stub(:print_board, mocked_method) do
      @game.print_board
    end
    mocked_method.verify
  end

  def test_that_print_board_can_call_the_boardclis_print_message_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:print_message, mocked_method) do
      @game.print_board
    end
    mocked_method.verify
  end

  def test_that_print_board_can_call_the_boardclis_print_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:print, mocked_method) do
      @game.print_board
    end
    mocked_method.verify
  end

  def test_that_print_board_can_call_the_boardclis_set_board_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:set_board, mocked_method) do
      @game.print_board
    end
    mocked_method.verify
  end

  def test_that_print_board_can_call_the_boardclis_show_bombs_method
    @game.bcli = @bcli
    @game.board = @board

    mocked_method = MiniTest::Mock.new

    @game.bcli.stub(:show_bombs, mocked_method) do
      @game.print_board
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

  def test_that_it_can_access_position_by_coordinates
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [1,3]
    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_place_a_move_on_the_board
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [7,6]
    @game.place_move(move)
    assert_equal "X", @game.get_position(move)
  end

  def test_that_it_can_show_adjacent_empties_on_the_board
    skip
    @game.set_bomb_count(5)
    @game.bcli = @bcli
    @game.board = @board
    @game.board.bomb_positions = [10, 11, 12, 13, 14, 15]
    @game.board.set_row_size(100)
    @game.board.set_board_positions(100)

    mocked_method = MiniTest::Mock.new

    @game.board.stub(:show_adjacent_empties, mocked_method) do
      @game.place_move([4,4])
    end
    mocked_method.verify
  end

  def test_that_it_has_a_game_over_attribute
    @game.respond_to?("game_over")
  end

  def test_that_it_can_set_the_game_to_game_over
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    coords = [3,1]
    @game.place_move(coords)
    assert @game.game_over
  end

  def test_that_it_can_set_the_BoardCLis_show_bombs_attribute
    @game.show_bombs = true
    assert @game.bcli.show_bombs
  end

  def test_that_it_can_turn_off_the_BoardCLis_show_bombs_attribute
    @game.show_bombs = "random string"
    refute @game.bcli.show_bombs
  end
end
