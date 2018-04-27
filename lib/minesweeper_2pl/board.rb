module Minesweeper
  class Board
    attr_accessor :size, :bomb_positions, :positions
    attr_reader :row_size, :bomb_count

    def initialize(row_size, bomb_count)
      @row_size = row_size
      @bomb_count = bomb_count
      @size = row_size * row_size
    end

    def set_positions(board_size)
      set_bombs
      set_board_positions(board_size)
    end

    def set_board_positions(board_size)
      @positions = (0...board_size).map do |cell|
        bomb_positions.include?(cell) ? "B" : " "
      end
    end

    def set_bombs
      @bomb_positions = []
      bombs = (0..size-1).to_a.shuffle
      @bomb_positions = bombs.first(bomb_count)
    end

    def show_adjacent_empties(position)
      spaces = spaces_to_clear(position)
      spaces.each do |space|
        positions[space] = "-"
      end
    end

    def show_adjacent_empties_with_value(position)
      spaces = spaces_to_clear(position)
      spaces.each do |space|
        result = assign_value(space).to_s
        if positions[space].nil? || positions[space] == " "
          positions[space] = result
        elsif positions[space].include? "F"
          positions[space] = result + "F"
        end
      end
    end

    def neighboring_cells(position, empty=false)
      positions_array = []

      middle_row = (position / row_size).to_i * row_size
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

      cells_hash = {}

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
        empties.concat(neighboring_cells(position, true))
        checked << position
        empties.uniq!
        empties -= checked
      end
      checked.shift
      checked
    end

    def assign_value(position)
      if is_empty?(position)
        cells_to_check = neighboring_cells(position)
        sum = 0
        cells_to_check.each do |cell_position|
          sum += check_position(cell_position)
        end
      end
      sum
    end

    def is_empty?(position)
      !["B", "X", "BF"].include? positions[position]
    end

    private

      def within_bounds(relative_position, row)
        relative_position >= 0 && relative_position <= size && relative_position >= row && relative_position < row + row_size
      end

      def check_position(position)
        (["B", "BF"].include? positions[position]) ? 1 : 0
      end
  end
end
