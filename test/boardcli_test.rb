require "test_helper"

class BoardCliTest < Minitest::Test

  def test_that_boardcli_has_a_print_method
    bcli = Minesweeper_2pl::BoardCli.new
    assert bcli.respond_to?(:print)
  end

end
