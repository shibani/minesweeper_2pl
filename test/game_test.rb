require "test_helper"

class GameTest < Minitest::Test

  def test_that_it_has_a_game_class
    game = Minesweeper_2pl::Game.new
    refute_nil game
  end

end
