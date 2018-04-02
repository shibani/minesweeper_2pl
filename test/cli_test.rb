require "test_helper"

class CliTest < Minitest::Test

  def test_that_it_has_a_cli_class
    cli = Minesweeper_2pl::CLI.new
    refute_nil cli
  end

  def test_that_cli_can_write_to_the_console
    cli = Minesweeper_2pl::CLI.new
    out, err = capture_io do
      cli.print("welcome to minesweeper\n")
    end
    assert_equal("welcome to minesweeper\n", out)
  end

  def test_that_cli_has_a_print_method
    cli = Minesweeper_2pl::CLI.new
    assert cli.respond_to?(:print)
  end

end
