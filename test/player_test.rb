require "test_helper"

class PlayerTest < Minitest::Test
  def test_that_it_has_a_player_class
    player = Minesweeper_2pl::Player.new
    refute_nil player
  end

end
