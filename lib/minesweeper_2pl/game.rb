module Minesweeper
  class Game
    attr_accessor :board, :board_formatter, :game_over

    def initialize(row_size, bomb_count=0)
      board_formatter = BoardFormatter.new
      board = Board.new(row_size, bomb_count)

      self.board = board
      set_board_positions(row_size)
      self.board_formatter = board_formatter
    end

    def row_size
      board.row_size
    end

    def bomb_count
      board.bomb_count
    end

    def set_bomb_positions(array)
      board.bomb_positions = array
    end

    def bomb_positions
      board.bomb_positions
    end

    def set_positions(array)
      array.each.with_index do |position, i|
        board_positions[i].update_cell_content(position)
      end
      board_positions.each.with_index do |position, i|
        content = board_positions[i].content
        if content == 'B'
          board_positions[i].update_cell_value(content)
        else
          value = board.assign_value(i)
          board_positions[i].update_cell_value(value)
        end
      end
    end

    def get_position(move)
      position = move_to_position(move)
      board_positions[position]
    end

    def set_board_positions(size)
      board.set_positions(size * size)
    end

    def board_positions
      board.positions
    end

    def board_values
      board_positions(&:value)
    end

    def set_board_values
      board.assign_values_to_all_positions
    end

    def print_board
      board_array = board_formatter.format_board_with_emoji(board)
      string = board_formatter.board_to_string(board_array, board)
      board_formatter.print_message(string)
    end

    def reassign_bomb(position)
      'reassigned!'
    end

    def place_move(move)
      position = move_to_position(move)
      if move.last == 'move'
        # if first_move?
        #   reassign_bomb(position) if position_is_a_bomb?(position)
        #   flood_fill
        # else
        #   #if position is a bomb, game over
        #   #if position has value reveal position
        #   #if value == 0, do flood-fill
        # end
        mark_move_on_board(position)
      elsif move.last == 'flag'
        mark_flag_on_board(position)
      end
      self.game_over = true if is_won?
    end

    def show_bombs=(msg)
      if msg == 'show'
        board_formatter.show_bombs = 'show'
      elsif msg == 'won'
        board_formatter.show_bombs = 'won'
      else
        board_formatter.show_bombs = false
      end
    end

    def is_won?
      all_non_bomb_positions_are_revealed? && all_bomb_positions_are_flagged?
    end

    def is_not_valid?(move=nil)
      move.nil? || get_position(move).status == 'revealed'
    end

    def gameloop_check_status
      print_board if game_over != true
      game_over
    end

    def check_win_or_loss
      if game_over
        if is_won?
          self.show_bombs = 'won'
          print_board
          result = 'win'
        else
          self.show_bombs = 'show'
          print_board
          result = 'lose'
        end
      end
      result
    end

    def mark_move_on_board(position)
      if position_is_a_bomb?(position)
        self.game_over = true
      else
        flood_fill(position)
      end
      board_positions[position].update_cell_status
    end

    def flood_fill(position)
      cells_to_reveal = []
      result = board.show_adjacent_empties_with_value(position)
      result.each do |adj_position|
        cells_to_reveal << adj_position unless board_positions[adj_position].status == 'revealed'
        board_positions[adj_position].update_cell_status
      end
      cells_to_reveal + [position]
    end

    def mark_flag_on_board(position)
      mark_flag(position)
    end

    private

    def move_to_position(move)
      if move.is_a? Array
        move[0] + board.row_size * move[1]
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

    def position_is_a_bomb?(position)
      board.bomb_positions.include?(position)
    end

    def position_is_empty?(position)
      board_positions[position].content == ' '
    end

    def position_is_flag?(position)
      board_positions[position].flag == 'F'
    end

    def position_includes_a_flag?(position)
      board_positions[position].flag == 'F'
    end

    def mark_board(position, content)
      board_positions[position].update_cell_content(content)
    end

    def mark_flag(position)
      board_positions[position].update_flag unless board_positions[position].status == 'revealed'
    end

    def all_non_bomb_positions_are_revealed?
      revealed = board_positions.select{|el| el.status == 'revealed'}
      non_bombs = board_positions.reject{|el| el.content == 'B'}
      ((revealed - non_bombs) + (non_bombs - revealed)).empty?
    end

    def all_bomb_positions_are_flagged?
      flags = board_positions.each_index.select{ |i| board_positions[i].flag == 'F' }
      ((flags - bomb_positions) + (bomb_positions - flags)).empty?
    end

    def first_move?
      board.all_positions_empty?
    end
  end
end
