module Minesweeper_2pl

  class Board
    attr_accessor :size, :bomb_count, :bomb_positions, :positions, :row_size, :value_hash

    def set_positions(positions)
      set_row_size(positions)
      set_bombs
      set_board_positions(positions)
    end

    def set_board_positions(positions)
      @positions = []
      positions.times do |position|
        if self.bomb_positions.include?(position)
          @positions << "B"
        else
          @positions << " "
        end
      end
    end

    def set_bombs
      @bomb_positions = []
      bombs = (0..self.size-1).to_a.shuffle
      @bomb_positions = bombs.first(bomb_count)
    end

    def set_row_size(size)
      @row_size = Math.sqrt(size).to_i
    end

    def neighboring_cells(position)
      positions_array = []

      row = (position / row_size).to_i * row_size
      bottom_row = (position / row_size).to_i * row_size - row_size
      top_row = (position / row_size).to_i * row_size + row_size

      left = position - 1
      right = position + 1
      bottom_left = position - row_size - 1
      bottom_middle = position - row_size
      bottom_right = position - row_size + 1
      top_left = position + row_size - 1
      top_middle = position + row_size
      top_right = position + row_size + 1

      positions_array << left if within_bounds(row, left)
      positions_array << right if within_bounds(row, position+1)

      positions_array << bottom_left if within_bounds(bottom_row, bottom_left)
      positions_array << bottom_middle if within_bounds(bottom_row, bottom_middle)
      positions_array << bottom_right if within_bounds(bottom_row, bottom_right)

      positions_array << top_left if within_bounds(top_row, top_left)
      positions_array << top_middle if within_bounds(top_row, top_middle)
      positions_array << top_right if within_bounds(top_row, top_right)

      positions_array
    end

    def assign_value(position)
      if is_empty?(position)
        cells_to_check = neighboring_cells(position)
        sum = 0
        cells_to_check.each do |position|
          sum += check_position(position)
        end
      end
      sum
    end

    def adjacent_empties(position)
      empties = []
      self.neighboring_cells(position).each do |position|
        empties << position if is_empty?(position)
      end
      empties
    end

    def is_empty?(position)
      !["B", "X"].include? self.positions[position]
    end

    private
      def within_bounds(row, relative_position)
        relative_position >= 0 && relative_position <= size && relative_position >= row && relative_position < row + row_size
      end

      def check_position(position)
        self.positions[position] == "B" ? 1 : 0
      end
  end
end
