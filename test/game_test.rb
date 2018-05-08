require "test_helper"

class GameTest < Minitest::Test
  def setup
    @game = Minesweeper::MockGame.new(5,5)
  end

  def test_that_it_has_a_game_class
    refute_nil @game
  end

  def test_that_initialize_can_create_a_new_board
    refute_nil @game.board
  end

  def test_that_initialize_creates_a_new_board_with_row_size
    assert_equal 5, @game.board.row_size
  end

  def test_that_initialize_creates_a_new_board_with_bomb_count
    assert_equal 5, @game.board.bomb_count
  end

  def test_that_initialize_can_create_a_new_boardcli
    refute_nil @game.bcli
  end

  def test_that_initialize_can_set_the_rowsize
    result = @game.board.row_size

    assert_equal 5, result
  end

  def test_that_initialize_can_set_the_board_size
    result = @game.board.size

    assert_equal 25, result
  end

  def test_that_initialize_can_set_the_bomb_count
    result = @game.board.bomb_count

    assert_equal 5, result
  end

  def test_that_initialize_can_set_the_boards_positions
    assert_equal 25, @game.board_positions.size
  end

  def test_that_it_can_print_the_board
    @game.set_input!("printed board goes here")

    out, err = capture_io do
      @game.print_board
    end
    assert_equal "printed board goes here", out
  end

  def test_that_it_can_set_the_bomb_positions_with_an_array
    bomb_positions = [10, 11, 12, 13, 14]
    @game.set_bomb_positions(bomb_positions)

    assert_matched_arrays bomb_positions, @game.board.bomb_positions
  end

  def test_that_it_can_set_the_board_positions_with_an_array
    positions = [ " ", " ", " ", " ", " ",
                  " ", " ", " ", " ", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_positions(positions)

    assert_matched_arrays positions, @game.board_positions
  end

  def test_that_it_can_get_the_games_row_size
    assert_equal 5, @game.row_size
  end

  def test_that_it_can_get_the_games_bomb_count
    assert_equal 5, @game.bomb_count
  end

  def test_that_it_can_get_the_games_board_positions
    result = @game.board_positions

    assert_equal 25, result.size
  end

  def test_that_it_can_show_adjacent_empties_on_the_board
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ " ", " ", " ", " ", " ",
                  " ", " ", " ", " ", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move1 = [0,0,"move"]
    move2 = [3,1,"move"]
    move3 = [2,1]
    @game.place_move(move1)
    @game.place_move(move2)

    result = @game.get_position(move3)

    assert_equal "3", result
  end

  def test_that_it_can_access_position_by_coordinates
    bomb_positions = [13, 15, 16, 18, 19]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "BF", "X",
                  "BF", "BF", "X", "B", "BF",
                  "X", "X", "X", "X", "X"]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)

    move = [3,3, "move"]

    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_place_a_move_on_the_board
    bomb_positions = [13, 15, 16, 18, 19]
    positions = [ " ", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "BF", "X",
                  "BF", "BF", "X", "B", "BF",
                  "X", "X", "X", "X", "X"]
    @game.set_bomb_positions(bomb_positions)
    move = [0,0, "move"]

    @game.place_move(move)

    assert_equal "X", @game.get_position(move)
  end

  def test_that_it_has_a_game_over_attribute
    @game.respond_to?("game_over")
  end

  def test_that_it_can_set_the_game_to_game_over
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", " ", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [3,1, "move"]

    @game.place_move(move)

    assert @game.game_over
  end

  def test_that_it_can_set_a_flag
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  " ", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [0,1, "flag"]

    @game.place_move(move)

    assert_equal "F", @game.get_position(move)
  end

  def test_that_it_can_set_a_flag_2
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  " ", "X", "X", "X", "X",
                  "B", "B", "B", "B", "B",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [3,2, "flag"]

    @game.place_move(move)

    assert_equal "BF", @game.get_position(move)
  end

  def test_that_it_can_remove_a_flag
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  " ", "X", "X", "X", "X",
                  "BF", "B", "B", "BF", "B",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [1,2, "flag"]

    @game.place_move(move)
    @game.place_move(move)

    assert_equal "B", @game.get_position(move)
  end

  def test_that_it_can_check_if_a_game_is_over_1
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "B", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [2,2, "flag"]

    @game.place_move(move)

    assert @game.is_won?
  end

  def test_that_it_can_check_if_a_game_is_over_2
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "B", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [2,2, "move"]

    @game.place_move(move)

    assert @game.game_over
  end

  def test_that_it_can_check_if_a_game_is_over_3
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "B", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [0,1, "flag"]

    @game.place_move(move)

    refute @game.game_over
  end

  def test_that_it_can_set_the_BoardClis_show_bombs_attribute
    @game.show_bombs = "show"

    assert_equal("show", @game.bcli.show_bombs)
  end

  def test_that_it_can_turn_off_the_BoardClis_show_bombs_attribute
    @game.show_bombs = "random string"

    refute @game.bcli.show_bombs
  end

  def test_that_it_can_set_the_BoardClis_show_bombs_attribute_to_won
    @game.show_bombs = "won"

    assert_equal("won", @game.bcli.show_bombs)
  end

  def test_that_it_can_check_if_a_game_is_won
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "B", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [2,2, "flag"]

    @game.place_move(move)

    assert(@game.is_won?)
  end

  def test_that_it_can_check_if_the_game_is_won
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    assert(@game.is_won?)
  end

  def test_that_it_can_check_if_the_game_is_not_won
    bomb_positions = [10, 11, 12, 13, 14]
    @game.set_bomb_positions(bomb_positions)
    @game.board.set_board_positions(5)

    refute(@game.is_won?)
  end

  def test_that_it_can_check_if_a_move_is_valid_1
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = [0,0, "move"]

    assert(@game.is_not_valid?(move))
  end

  def test_that_it_can_check_if_a_move_is_valid_2
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    move = nil

    assert(@game.is_not_valid?(move))
  end

  def test_that_gameloop_check_status_can_check_if_the_game_is_over
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  " ", " ", " ", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)

    refute(@game.gameloop_check_status)
  end

  def test_that_gameloop_check_status_can_print_the_board
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)

    @game.game_over = false
    @game.set_input!("display board")

    out, err = capture_io do
      @game.gameloop_check_status
    end

    assert_equal("display board", out)
  end

  def test_that_it_can_check_if_the_game_is_won_or_lost
    bomb_positions = [10, 11, 12, 13, 14]
    positions = [ "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X",
                  "BF", "BF", "BF", "BF", "BF",
                  "X", "X", "X", "X", "X",
                  "X", "X", "X", "X", "X" ]
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
    @game.game_over = true

    assert_equal("win", @game.check_win_or_loss)
  end

  def test_that_it_can_convert_a_position_to_a_move
    result = @game.position_to_move(35)
    assert_equal([0, 7], result)
  end

end
