require "test_helper"

class GameTest < Minitest::Test
  def setup
    @game = Minesweeper_2pl::Game.new
    @board = Minesweeper_2pl::Board.new
    @bcli = Minesweeper_2pl::BoardCli.new
    #@game.setup(10,100)
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
    @game.setup(10, 100)
    refute_nil @game.board
  end

  def test_that_setup_can_create_a_new_boardcli
    @game.setup(10, 100)
    refute_nil @game.bcli
  end

  def test_that_setup_can_set_the_board_size
    @game.setup(10,100)
    result = @game.set_board_size(10)
    result = @game.board.size

    assert_equal 100, result
  end

  def test_that_setup_can_set_the_bomb_count
    @game.setup(10,100)
    result = @game.set_bomb_count(60)
    result = @game.board.bomb_count

    assert_equal 60, result
  end

  def test_that_setup_can_set_the_boards_positions
    @game.setup(10,100)
    @game.board.bomb_count = 10
    @game.board.size = 36
    result = @game.set_board_positions(6)

    assert_equal 36, result
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
      @game.set_board_size(10)
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
      @game.set_board_positions(10)
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
    @game.setup(10,100)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [1,3, "move"]
    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_place_a_move_on_the_board
    @game.setup(10,100)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [7,6, "move"]
    @game.place_move(move)
    assert_equal "X", @game.get_position(move)
  end

  def test_that_it_can_show_adjacent_empties_on_the_board
    # @game.set_bomb_count(5)
    # @game.bcli = @bcli
    # @game.board = @board
    # @game.board.bomb_positions = [10, 11, 12, 13, 14, 15]
    # @game.board.set_row_size(100)
    # @game.board.set_board_positions(100)
    #
    # mocked_method = MiniTest::Mock.new
    #
    # @game.board.stub(:show_adjacent_empties, mocked_method) do
    #   @game.place_move([25,25])
    # end
    # mocked_method.verify
  end

  def test_that_it_has_a_game_over_attribute
    @game.respond_to?("game_over")
  end

  def test_that_it_can_set_the_game_to_game_over
    @game.setup(10,100)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    coords = [3,1, "move"]

    @game.place_move(coords)

    assert @game.game_over
  end

  def test_that_it_can_set_a_flag
    @game.setup(10,0)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [3,7, "flag"]

    @game.place_move(move)

    assert_equal "F", @game.get_position(move)
  end

  def test_that_it_can_set_a_flag_2
    @game.setup(10,100)
    move = [3,1, "flag"]

    @game.place_move(move)

    assert_equal "BF", @game.get_position(move)
  end

  def test_that_it_can_remove_a_flag
    @game.setup(10,100)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [3,7, "flag"]

    @game.place_move(move)
    @game.place_move(move)

    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_check_if_a_game_is_over_1
    @game.setup(4,0)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [3,3, "flag"]

    @game.place_move(move)

    assert @game.game_over
  end

  def test_that_it_can_check_if_a_game_is_over_2
    @game.setup(4,0)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [3,3, "move"]

    @game.place_move(move)

    assert @game.game_over
  end

  def test_that_it_can_check_if_a_game_is_over_3
    @game.setup(4,0)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [0,1, "flag"]

    @game.place_move(move)

    refute @game.game_over
  end

  def test_that_it_can_set_the_BoardClis_show_bombs_attribute
    @game.setup(10,100)
    @game.show_bombs = true

    assert @game.bcli.show_bombs
  end

  def test_that_it_can_turn_off_the_BoardClis_show_bombs_attribute
    @game.setup(10,100)
    @game.show_bombs = "random string"

    refute @game.bcli.show_bombs
  end

  def test_that_it_can_set_the_BoardClis_show_bombs_attribute_to_won
    @game.setup(10,100)
    @game.show_bombs = "won"

    assert_equal("won", @game.bcli.show_bombs)
  end

  def test_that_it_can_check_if_a_game_is_won
    @game.setup(4,0)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [3,3, "flag"]

    @game.place_move(move)

    assert(@game.is_won?)
  end

  def test_that_it_can_check_if_the_game_is_not_won
    @game.setup(4,0)
    @game.board.bomb_count = 5
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.set_board_positions(25)

    refute(@game.is_won?)
  end

  def test_that_it_can_check_if_the_game_is_won
    @game.setup(5,0)
    @game.board.bomb_count = 5
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X"]
    assert(@game.is_won?)
  end

  def test_that_it_can_check_if_a_move_is_valid
    @game.setup(4,0)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [0,0, "move"]

    refute(@game.valid_move?(move))
  end

  def test_that_it_can_check_the_games_status
    @game.setup(5,0)
    @game.board.bomb_count = 5
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X"]
    assert("won", @game.check_game_status)
  end

end
