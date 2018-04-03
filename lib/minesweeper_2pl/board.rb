module Minesweeper_2pl

  class Board
    attr_accessor :size
    attr_accessor :bomb_count
    attr_reader :bomb_positions
    attr_reader :positions
    attr_reader :row_size

    def set_positions(positions)
      set_row_size(positions)
      set_bombs
      @positions = []
      positions.times do |count|
        if self.bomb_positions.include?(count)
          @positions << "B"
        else
          @positions << " "
        end
      end
    end

    def set_bombs
      bombs = (0..self.size-1).to_a.shuffle
      @bomb_positions = bombs.slice(0, bomb_count)
    end

    def set_row_size(size)
      @row_size = Math.sqrt(size)
    end
  end
end
