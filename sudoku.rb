class Sudoku
  attr_accessor :board

  POSSIBLE_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def initialize
    @board = Array.new(9){Array.new(9){Array.new(1)}}
  end

  def possible_values_for_cell(row, column)
    found_values = found_column_values(column) &&
      found_row_values(row) &&
      found_nonet_values(row, column)

    POSSIBLE_VALUES - found_values
  end


  private


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
    row_nonet = (row / 3) * 3
    column_nonet = (column / 3) * 3

    3.times do |i|
      3.times do |j|
        board_value = @board[row_nonet + i][column_nonet + j]

        if board_value.length == 1 && !board_value[0].nil?
          values << board_value[0]
        end
      end
    end

    values
  end
end

sudoku = Sudoku.new
sudoku.board[0] = [[4], [nil], [nil], [nil], [nil], [nil], [nil], [6], [9]]
sudoku.board[1] = [[nil], [nil], [3], [2], [nil], [nil], [nil], [8], [1]]
sudoku.board[2] = [[nil], [nil], [nil], [6], [nil], [nil], [4], [nil], [nil]]
sudoku.board[3] = [[1], [5], [7], [nil], [nil], [nil], [6], [9], [nil]]
sudoku.board[4] = [[nil], [nil], [nil], [nil], [7], [nil], [8], [nil], [2]]
sudoku.board[5] = [[2], [nil], [4], [nil], [1], [6], [nil], [nil], [nil]]
sudoku.board[6] = [[5], [nil], [nil], [nil], [nil], [3], [7], [2], [8]]
sudoku.board[7] = [[6], [nil], [2], [8], [9], [4], [nil], [3], [nil]]
sudoku.board[8] = [[8], [3], [1], [5], [2], [nil], [nil], [4], [nil]]

