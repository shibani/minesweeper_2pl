module Minesweeper_2pl
  class App
    SIZE = 100
    BOMB_COUNT = 10
    attr_accessor :game, :cli

    def start
      self.setup
      self.play_game
    end

    def setup
      game = Game.new
      cli = CLI.new
      self.cli = cli
      self.game = game
      self.game.setup(SIZE, BOMB_COUNT)
    end

    def play_game
      self.game.print_board
      move = nil
      while move == nil
        self.cli.ask_for_move
        move = self.cli.get_player_input(self.game)
      end
      self.game.move_to_coordinates(move)
      #check if position is a bomb
      #place on board
      #show message
    end
  end
end
