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

    def show_adjacent_empties(position)
      spaces = spaces_to_clear(position)
      spaces.each do |space|
        self.positions[space] = "-"
      end
    end

    def show_adjacent_empties_with_value(position)
      spaces = spaces_to_clear(position)
      spaces.each do |space|
        result = assign_value(space).to_s
        if self.positions[space].nil? || self.positions[space] == " "
          self.positions[space] = result
        elsif self.positions[space].include? "F"
          self.positions[space] = result + "F"
        end
      end
    end

    def neighboring_cells(position, empty=false)
      positions_array = []

      middle_row = (position / self.row_size).to_i * self.row_size
      bottom_row = (position / self.row_size).to_i * self.row_size - self.row_size
      top_row = (position / self.row_size).to_i * self.row_size + self.row_size

      left = position - 1
      right = position + 1
      bottom_left = position - self.row_size - 1
      bottom_middle = position - self.row_size
      bottom_right = position - self.row_size + 1
      top_left = position + self.row_size - 1
      top_middle = position + self.row_size
      top_right = position + self.row_size + 1

      cells_hash = Hash.new

      cells_hash[left] = middle_row
      cells_hash[right] = middle_row

      cells_hash[bottom_left] = bottom_row
      cells_hash[bottom_middle] = bottom_row
      cells_hash[bottom_right] = bottom_row

      cells_hash[top_left] = top_row
      cells_hash[top_middle] = top_row
      cells_hash[top_right] = top_row

      if empty
        cells_hash.each do |cell_position, cell_row|
          positions_array << cell_position if within_bounds(cell_position, cell_row) && is_empty?(cell_position)
        end
      else
        cells_hash.each do |cell_position, cell_row|
          positions_array << cell_position if within_bounds(cell_position, cell_row)
        end
      end

      positions_array
    end

    def spaces_to_clear(position)
      empties = [position]
      checked = []
      while empties.length > 0
        position = empties.first
        empties.concat(self.neighboring_cells(position, true))
        checked << position
        empties.uniq!
        empties = empties - checked
      end
      checked.shift
      checked
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

    def is_empty?(position)
      !["B", "X"].include? self.positions[position]
    end

    def is_won?
      self.size - self.positions.select{|el| el == "X"}.length == self.bomb_count
    end

    private
      def within_bounds(relative_position, row)
        relative_position >= 0 && relative_position <= size && relative_position >= row && relative_position < row + self.row_size
      end

      def check_position(position)
        self.positions[position] == "B" ? 1 : 0
      end
  end
end
