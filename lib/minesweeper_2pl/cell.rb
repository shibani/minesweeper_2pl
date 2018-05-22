module Minesweeper
  class Cell
    attr_reader :content, :value, :status, :flag

    def initialize(content)
      @content = content
      @flag = nil
    end

    def update_cell_content(content)
      @content = content
    end

    def update_cell_value(value)
      @value = value
    end

    def update_cell_status
      @status = 'revealed'
    end

    def update_flag
      @flag = @flag.nil? ? 'F' : nil
    end

  end
end
