require "test_helper"

class CliTest < Minitest::Test

  def test_that_it_has_a_cli_class
    cli = Minesweeper_2pl::CLI.new
    refute_nil cli
  end

end
