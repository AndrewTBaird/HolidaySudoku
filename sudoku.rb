class Solver
  attr_accessor :board

  POSSIBLE_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def initialize
    @board = Array.new(9){Array.new(9){Array.new(1)}}
  end

  def compute_possible_values(row, column)
    found_values = []

    found_values.merge!(found_column_values(column))
    found_values.merge!(found_row_values(row))
    # found_values << found_nonet_values(row, column)
    #solve for nonet values here

    POSSIBLE_VALUES - found_values
  end

  def found_column_values(column)
    values = []

    9.times do |index|
      if @board[index][column].length == 1 && !@board[index][column][0].nil?
        values << @board[index][column][0]
      end
    end

    values
  end

  def found_row_values(row)
    values = []

    9.times do |index|
      if @board[row][index].length == 1 && !@board[row][index][0].nil?
        values << @board[row][index][0]
      end
    end

    values
  end

  def found_nonet_values(row, column)
    values = []
    row_nonet = row / 3
    column_nonet = column / 3

    3.times do |i|
      3.times do |j|
        board_value = @board[row_nonet + i][column_nonet + j]

        if board_value.length == 1 && !board_value[0].nil?
          values << board_value
        end
      end
    end

    values
  end
  
end

solver = Solver.new
solver.board[0][0] = [5]

