class Sudoku
  attr_accessor :board

  POSSIBLE_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def initialize(board_string)
    @board = build_board_from_board_string(board_string)
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

  def build_board_from_board_string(board_string)
    board = Array.new(9){Array.new(9){Array.new(1)}}

    board_string.split('').each_with_index do |number_string, index|
      number = number_string.to_i
      unless number == 0
        board[index / 9][index % 9][0] = number
      end
    end

    board
  end

  def print_board
    formatted_board = ""

    9.times do |i|
      9.times do |j|
        formatted_board += (@board[i][j][0].to_s + " ")
      end
      formatted_board += "\n"
    end

    formatted_board
  end


  private


  def possible_values_for_cell(row, column)
    found_values = found_column_values(column) |
      found_row_values(row) |
      found_nonet_values(row, column)

    POSSIBLE_VALUES - found_values
  end


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

#sets of sudoku puzzles can be found at https://www.kaggle.com/bryanpark/sudoku

board_string = '004300209005009001070060043006002087190007400050083000600000105003508690042910300'
sudoku = Sudoku.new(board_string)

sudoku.solve

print sudoku.print_board

