module Minesweeper
  class Board
    attr_accessor :size, :bomb_positions, :positions, :values
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
      self.positions = (0...board_size).map do |cell|
        bomb_positions.include?(cell) ? 'B' : ' '
      end
      self.values = @positions.map.with_index do |position, i|
        position == 'B' ? 'B' : assign_value(i).to_s
      end
    end

    def set_bombs
      @bomb_positions = []
      bombs = (0..size-1).to_a.shuffle
      @bomb_positions = bombs.first(bomb_count)
    end

    def assign_values_to_all_positions
      positions.map.with_index do |position, i|
        positions[i] = position == 'B' ? 'B' : assign_value(i).to_s
      end
    end

    def show_adjacent_empties_with_value(position)
      # disregard flags
      # if board.all_positions_empty? empties is this formula
      # if board.all_positions_empty? and board.postions[position] == 'B', CLEAR OUT bomb (or swap bomb?) and empties is this formula
      # if this is a move and position is zero, empties is this formula
      # if position is a number, empties is the number
      # set position to revealed
      spaces = spaces_to_clear(position)
      spaces.each do |space|
        result = values[space]
        if positions[space].nil? || positions[space] == ' '
          positions[space] = result
        elsif positions[space].include? 'F'
          positions[space] = result + 'F'
        end
      end
      spaces
    end

    def neighboring_cells(position, empty=false)
      positions_array = []

      middle_row = (position / row_size).to_i * row_size
      bottom_row = (position / row_size).to_i * row_size - row_size
      top_row = (position / row_size).to_i * row_size + row_size

      left = position - 1
      right = position + 1
      top = position + row_size
      bottom = position - row_size

      bottom_left = position - row_size - 1
      bottom_right = position - row_size + 1

      top_left = position + row_size - 1
      top_right = position + row_size + 1

      cells_hash = {}

      cells_hash[left] = middle_row
      cells_hash[right] = middle_row

      cells_hash[bottom_left] = bottom_row
      cells_hash[bottom] = bottom_row
      cells_hash[bottom_right] = bottom_row

      cells_hash[top_left] = top_row
      cells_hash[top] = top_row
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
      spaces_to_clear = [position]
      cells_to_check = [position]
      checked = []

      while cells_to_check.length.positive?
        cell = cells_to_check.first
        neighboring_cells(cell).each do |cell_position|
          spaces_to_clear << cell_position unless values[cell_position].include? 'B'
          cells_to_check << cell_position if values[cell_position] == '0'
        end
        if checked.empty?
          spaces_to_clear = spaces_to_clear.uniq
          cells_to_check = cells_to_check.uniq
        else
          spaces_to_clear = spaces_to_clear.uniq
          cells_to_check = cells_to_check.uniq - checked
        end
        checked << cell
      end
      spaces_to_clear - [position]
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
      !['B', 'X', 'BF'].include? positions[position]
    end

    def all_positions_empty?
      !positions.include?('X')
    end

    private

      def within_bounds(relative_position, row)
        relative_position >= 0 && relative_position < size && relative_position >= row && relative_position < row + row_size
      end

      def check_position(position)
        (['B', 'BF'].include? positions[position]) ? 1 : 0
      end
  end
end
