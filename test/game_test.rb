require "test_helper"

class GameTest < Minitest::Test
  def setup
    @game = Minesweeper::Game.new(0, 0)
    @game2 = Minesweeper::Game.new(10, 100)
    @game3 = Minesweeper::MockGame.new(4,4)
  end

  def test_that_it_has_a_game_class
    refute_nil @game2
  end

  def test_that_initialize_can_create_a_new_board
    refute_nil @game2.board
  end

  def test_that_initialize_can_create_a_new_boardcli
    refute_nil @game2.bcli
  end

  def test_that_initialize_can_set_the_rowsize
    result = @game2.board.row_size

    assert_equal 10, result
  end

  def test_that_initialize_can_set_the_board_size
    result = @game2.board.size

    assert_equal 100, result
  end

  def test_that_initialize_can_set_the_bomb_count
    result = @game2.board.bomb_count

    assert_equal 100, result
  end

  def test_that_initialize_can_set_the_boards_positions
    assert_equal 100, @game2.board_positions.size
  end

  def test_that_it_can_print_the_board
    @game3.set_input!("printed board goes here")

    assert_equal "printed board goes here", @game3.print_board
  end

  def test_that_it_can_get_the_games_board_positions
    result = @game3.board_positions

    assert_equal 16, result.size
  end

  def test_that_it_can_show_adjacent_empties_on_the_board
    @game.set_row_size(5)
    @game.set_board_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = [
            " ", " ", " ", " ", " ",
            " ", " ", " ", " ", "X",
            "BF", "BF", "BF", "BF", "BF",
            "X", "X", "X", "X", "X",
            "X", "X", "X", "X", "X"]
    move1 = [0,0,"move"]
    move2 = [3,1,"move"]
    move3 = [2,1]
    @game.place_move(move1)
    @game.place_move(move2)
    puts "positions: " + @game.board.positions.to_s

    result = @game.get_position(move3)

    assert_equal "3", result
  end

  def test_that_it_can_access_position_by_coordinates
    @game.set_row_size(4)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]

    move = [3,3, "move"]

    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_place_a_move_on_the_board
    @game.set_row_size(10)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    move = [7,6, "move"]

    @game.place_move(move)

    assert_equal "X", @game.get_position(move)
  end

  def test_that_it_has_a_game_over_attribute
    @game.respond_to?("game_over")
  end

  def test_that_it_can_set_the_game_to_game_over
    @game.set_row_size(5)
    @game.set_board_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = [
            "X", "X", "X", "X", "X",
            "X", "X", "X", " ", "X",
            "BF", "BF", "BF", "BF", "BF",
            "X", "X", "X", "X", "X",
            "X", "X", "X", "X", "X"]
    move = [3,1, "move"]

    @game.place_move(move)

    assert @game.game_over
  end

  def test_that_it_can_set_a_flag
    @game.set_row_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = [
            "X", "X", "X", "X", "X",
            " ", "X", "X", "X", "X",
            "BF", "BF", "BF", "BF", "BF",
            "X", "X", "X", "X", "X",
            "X", "X", "X", "X", "X"]
    move = [0,1, "flag"]

    @game.place_move(move)

    assert_equal "F", @game.get_position(move)
  end

  def test_that_it_can_set_a_flag_2
    @game.set_row_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = [
            "X", "X", "X", "X", "X",
            " ", "X", "X", "X", "X",
            "B", "B", "B", "B", "B",
            "X", "X", "X", "X", "X",
            "X", "X", "X", "X", "X"]
    move = [3,2, "flag"]

    @game.place_move(move)

    assert_equal "BF", @game.get_position(move)
  end

  def test_that_it_can_remove_a_flag
    @game.set_row_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = [
            "X", "X", "X", "X", "X",
            " ", "X", "X", "X", "X",
            "BF", "B", "B", "BF", "B",
            "X", "X", "X", "X", "X",
            "X", "X", "X", "X", "X"]
    move = [1,2, "flag"]

    @game.place_move(move)
    @game.place_move(move)

    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_check_if_a_game_is_over_1
    @game.set_row_size(4)
    @game.set_board_size(4)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [3,3, "flag"]

    @game.place_move(move)

    assert @game.is_won?
  end

  def test_that_it_can_check_if_a_game_is_over_2
    @game.set_row_size(4)
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
    @game.set_row_size(4)
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
    @game.set_row_size(5)
    @game.set_bomb_count(5)

    @game.show_bombs = "show"

    assert_equal("show", @game.bcli.show_bombs)
  end

  def test_that_it_can_turn_off_the_BoardClis_show_bombs_attribute
    @game.set_row_size(5)
    @game.set_bomb_count(5)

    @game.show_bombs = "random string"

    refute @game.bcli.show_bombs
  end

  def test_that_it_can_set_the_BoardClis_show_bombs_attribute_to_won
    @game.set_row_size(5)
    @game.set_bomb_count(5)

    @game.show_bombs = "won"

    assert_equal("won", @game.bcli.show_bombs)
  end

  def test_that_it_can_check_if_a_game_is_won
    @game.set_row_size(4)
    @game.set_board_size(4)
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

  def test_that_it_can_check_if_the_game_is_won
    @game.set_row_size(5)
    @game.set_board_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X"]
    assert(@game.is_won?)
  end

  def test_that_it_can_check_if_the_game_is_not_won
    @game.set_row_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.set_board_positions(5)

    refute(@game.is_won?)
  end

  def test_that_it_can_check_if_a_move_is_valid_1
    @game.set_row_size(4)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = [0,0, "move"]

    assert(@game.is_not_valid?(move))
  end

  def test_that_it_can_check_if_a_move_is_valid_2
    @game.set_row_size(4)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [11, 12, 13, 15]
    @game.board.positions = [
            "X", "X", "X", "X",
            "X", "X", "X", "X",
            "X", "X", "X", "BF",
            "BF", "BF", "X", "B"]
    move = nil

    assert(@game.is_not_valid?(move))
  end

  def test_that_it_can_check_the_games_status
    @game.set_row_size(5)
    @game.set_bomb_count(5)
    @game.board.bomb_positions = [10, 11, 12, 13, 14]
    @game.board.positions = ["X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X",
                        "BF", "BF", "BF", "BF", "BF",
                        "X", "X", "X", "X", "X",
                        "X", "X", "X", "X", "X"]
    assert("win", @game.check_game_status)
  end

  def test_that_gameloop_check_status_can_check_status
    @game.set_row_size(4)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [10, 11, 12, 13]
    @game.board.positions = ["X", "X", "X", "X",
                        " ", " ", " ", " ",
                        "B", "B", "B", "BF",
                        "X", "X", "X", "X"]
    refute(@game.gameloop_check_status)
  end

  def test_that_gameloop_check_status_can_print_the_board
    @game.set_row_size(4)
    @game.set_bomb_count(4)
    @game.board.bomb_positions = [10, 11, 12, 13]
    @game.board.positions = ["X", "X", "X", "X",
                        " ", " ", " ", " ",
                        "B", "B", "B", "BF",
                        "X", "X", "X", "X",
                        "X", "X", "X", "X"]
    out, err = capture_io do
      @game.gameloop_check_status
    end

    assert out.end_with?("===+\n")
  end

end
