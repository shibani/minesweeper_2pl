require "test_helper"

class AppTest < Minitest::Test

  def test_that_it_has_an_app_class
    app = Minesweeper_2pl::App.new
    refute_nil app
  end

  def test_that_it_says_hello_world
    app = Minesweeper_2pl::App.new
    assert app.call == "Hello World"
  end

end
