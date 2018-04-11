module Minesweeper_2pl
  class Game
    attr_accessor :bcli, :board, :game_over

    def setup(row_size, bomb_count)
      bcli = BoardCli.new
      board = Board.new

      self.board = board
      self.set_board_size(row_size)
      self.set_bomb_count(bomb_count)
      self.set_board_positions(row_size)
      self.bcli = bcli
    end

    def print_board
      positions = self.board_positions
      rowsize = self.board.row_size
      self.bcli.set_board(positions, rowsize)
      self.bcli.print_message(self.bcli.board)
    end

    def set_board_size(row_size)
      self.board.size = row_size * row_size
    end

    def set_bomb_count(bomb_count)
      self.board.bomb_count = bomb_count
    end

    def get_position(move)
      position = move_to_position(move)
      board_positions[position]
    end

    def board_positions
      self.board.positions
    end

    def set_board_positions(size)
      self.board.set_positions(size * size)
    end

    def place_move(move)
      position = move_to_position(move)
      if self.board.bomb_positions.include?(position)
        self.game_over = true
      else
        self.board.show_adjacent_empties(position)
        self.board.positions[position] = "X"
      end
    end

    def show_bombs=(msg)
      if msg == true
        self.bcli.show_bombs = true
      else
        self.bcli.show_bombs = false
      end
    end

    private

    def move_to_position(move)
      if move.is_a? Array
        move[0] + self.board.row_size * move[1]
      else
        raise
      end
    end

    def position_to_move(position)
      [
        (position % board.row_size).to_i,
        (position / board.row_size).to_i
      ]
    end

  end
end
