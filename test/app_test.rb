# require "test_helper"
#
# class AppTest < Minitest::Test
#   def setup
#     @app = Minesweeper_2pl::App.new
#     @mocked_app = Minesweeper_2pl::App.new
#     @mocked_game = Minesweeper_2pl::MockedGame.new
#     @mocked_cli = Minesweeper_2pl::MockedCli.new
#     @mocked_app.game = @mocked_game
#     @mocked_app.cli = @mocked_cli
#     @mocked_app.game.setup(100,100)
#   end
#
#   def test_that_it_has_an_app_class
#     refute_nil @mocked_app
#   end
#
#   def test_that_it_has_a_cli
#     refute_nil @mocked_app.cli
#   end
#
#   def test_that_it_has_a_start_method
#     assert @mocked_app.respond_to?(:start)
#   end
#
#   def test_that_it_has_a_setup_method
#     assert @mocked_app.respond_to?(:setup)
#   end
#
#   def test_that_it_creates_a_new_game
#     refute_nil @mocked_app.game
#   end
#
#   def test_that_it_calls_the_apps_setup_method
#     mocked_method = MiniTest::Mock.new
#     @mocked_app.stub(:setup, mocked_method) do
#       @mocked_app.stub(:play_game, nil) do
#         @mocked_app.start
#       end
#     end
#     mocked_method.verify
#   end
#
#   def test_that_it_calls_the_apps_play_game_method
#     mocked_method = MiniTest::Mock.new
#
#     @mocked_app.stub(:play_game, mocked_method) do
#       @mocked_app.stub(:setup, nil) do
#         @mocked_app.start
#       end
#     end
#     mocked_method.verify
#   end
#
#   # def test_setup_creates_a_new_cli
#   #   @mocked_app.setup
#   #   assert @mocked_app.cli.instance_of?(Minesweeper_2pl::CLI)
#   # end
#
#   def test_setup_sets_the_cli
#     mocked_method = MiniTest::Mock.new
#     mocked_method.expect :welcome, nil
#     mocked_method.expect :get_player_params, nil
#
#     @app.stub(:cli, mocked_method) do
#       @app.setup
#     end
#     mocked_method.verify
#   end
#
#   def test_setup_calls_clis_get_player_params_method
#     # mocked_method = MiniTest::Mock.new
#     #
#     # @mocked_app.cli.stub(:get_player_params, mocked_method) do
#     #   @mocked_app.setup
#     # end
#     # mocked_method.verify
#   end
#
#   def test_setup_creates_a_new_game
#   #   @mocked_app.setup
#   #   assert @mocked_app.game.instance_of?(Minesweeper_2pl::Game)
#   end
#
#   def test_setup_sets_the_game
#   #   mocked_method = MiniTest::Mock.new
#   #   mocked_method.expect :setup, nil, [Integer, Integer]
#   #
#   #   @app.stub(:game, mocked_method) do
#   #     @app.setup
#   #   end
#   #   mocked_method.verify
#   end
#
#   def test_setup_calls_games_setup_method
#   #   mocked_method = MiniTest::Mock.new
#   #
#   #   @mocked_app.game.stub(:setup, mocked_method) do
#   #     @mocked_app.setup
#   #   end
#   #   mocked_method.verify
#   end
#
#   def test_play_game_calls_games_print_board_method
#     mocked_game = MiniTest::Mock.new
#     @mocked_app.game.stub(:print_board, mocked_game) do
#       @mocked_app.play_game
#     end
#     mocked_game.verify
#   end
#
#   def test_play_game_calls_clis_ask_for_move_method
#     mocked_cli = MiniTest::Mock.new
#     @mocked_app.game.game_over = false
#     @mocked_app.cli.stub(:ask_for_move, mocked_cli) do
#       @mocked_app.play_game
#     end
#     mocked_cli.verify
#   end
#
#   def test_play_game_calls_clis_get_player_input_method
#     mocked_cli = MiniTest::Mock.new
#     mocked_cli.expect :get_player_input, true, [@mocked_game]
#     @mocked_cli.instance_exec(mocked_cli) do |mocked_cli|
#       @mock = mocked_cli
#       def get_player_input(game)
#         @mock.get_player_input(game)
#       end
#     end
#     @mocked_app.cli.get_player_input(@mocked_game)
#     mocked_cli.verify
#   end
#
#
#   def test_play_game_calls_the_convert_coordinates_method
#     mocked_game = MiniTest::Mock.new
#     mocked_game.expect :move_to_coordinates, Integer, [Integer]
#     @mocked_app.instance_exec(mocked_game) do |mocked_game|
#       @mock = mocked_game
#       def move_to_coordinates(game)
#         @mock.move_to_coordinates(game)
#       end
#     end
#     @mocked_app.move_to_coordinates(35)
#     mocked_game.verify
#   end
#
#   def test_play_game_can_place_a_move_on_the_board
#     mocked_game = MiniTest::Mock.new
#     mocked_game.expect :place_move, nil, [Integer]
#     @mocked_app.instance_exec(mocked_game) do |mocked_game|
#       @mock = mocked_game
#       def place_move(game)
#         @mock.place_move(game)
#       end
#     end
#     @mocked_app.place_move(35)
#     mocked_game.verify
#   end
#
#   def test_play_game_can_check_if_the_game_is_over
#     mocked_game = MiniTest::Mock.new
#     mocked_game.expect(:!=, nil, [true])
#     @mocked_app.game.stub(:game_over, mocked_game) do
#       @mocked_app.play_game
#     end
#     mocked_game.verify
#   end
#
#   def test_play_game_can_show_bombs_if_the_game_is_over
#     mocked_game = MiniTest::Mock.new
#     @mocked_app.game.game_over = true
#     @mocked_app.game.stub(:show_bombs=, mocked_game) do
#       @mocked_app.play_game
#     end
#     mocked_game.verify
#   end
#
#   def test_play_game_calls_the_games_show_bombs_method_if_the_game_is_over
#     mocked_game = MiniTest::Mock.new
#     @mocked_app.game.game_over = true
#     @mocked_app.game.stub(:show_bombs=, mocked_game) do
#       @mocked_app.play_game
#     end
#     mocked_game.verify
#   end
#
#   def test_play_game_calls_the_games_print_board_method_if_the_game_is_over
#     mocked_game = MiniTest::Mock.new
#     @mocked_app.game.game_over = true
#     @mocked_app.game.stub(:print_board, mocked_game) do
#       @mocked_app.play_game
#     end
#     mocked_game.verify
#   end
#
#   def test_play_game_calls_the_games_show_game_over_message_method
#     mocked_cli = MiniTest::Mock.new
#     @mocked_app.game.game_over = true
#     @mocked_app.cli.stub(:show_game_over_message, mocked_cli) do
#       @mocked_app.play_game
#     end
#     mocked_cli.verify
#   end
#
# end
