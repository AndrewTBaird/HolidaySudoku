class Sudoku
  attr_accessor :board

  POSSIBLE_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def initialize
    @board = Array.new(9){Array.new(9){Array.new(1)}}
  end

  def solve
    9.times do |i|
      9.times do |j|
        unless solved_cell?(i, j)
          board[i][j] = possible_values_for_cell(i, j)

          solve if solved_cell?(i, j)
        end
      end
    end
  end

  def possible_values_for_cell(row, column)
    found_values = found_column_values(column) |
      found_row_values(row) |
      found_nonet_values(row, column)

    POSSIBLE_VALUES - found_values
  end


  # private


  def found_column_values(column)
    values = []

    9.times do |index|
      if solved_cell?(index, column)
        values << @board[index][column][0]
      end
    end

    values
  end

  def found_row_values(row)
    values = []

    9.times do |index|
      if solved_cell?(row, index)
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


  def solved_cell?(row, column)
    @board[row][column].length == 1 && !@board[row][column][0].nil?
  end
end

sudoku = Sudoku.new
sudoku.board[0] = [[5], [nil], [1], [6], [nil], [7], [9], [nil], [nil]]
sudoku.board[1] = [[nil], [nil], [9], [nil], [nil], [3], [2], [5], [nil]]
sudoku.board[2] = [[8], [2], [7], [nil], [9], [nil], [nil], [nil], [nil]]
sudoku.board[3] = [[9], [nil], [2], [nil], [5], [1], [3], [7], [nil]]
sudoku.board[4] = [[3], [nil], [nil], [9], [8], [nil], [nil], [nil], [nil]]
sudoku.board[5] = [[nil], [nil], [5], [7], [nil], [6], [nil], [nil], [nil]]
sudoku.board[6] = [[4], [nil], [6], [nil], [7], [5], [nil], [3], [2]]
sudoku.board[7] = [[nil], [1], [nil], [nil], [nil], [nil], [7], [nil], [5]]
sudoku.board[8] = [[nil], [nil], [3], [nil], [nil], [nil], [1], [9], [6]]

sudoku.solve

