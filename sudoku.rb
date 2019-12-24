class GameBoard
  attr_accessor :board

  POSSIBLE_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def initialize
    create_board
  end

  private

  def create_board
    @board = Array.new(9){Array.new(9){Array.new(1)}}
  end
end

class Solver
  def self.solve(game_board)

  end

  def self.compute_possible_values(row, column)
    found_values = []

    #compute row
    9.times do |index|
      if @board[index][column].length == 1 && !@board[index][column][0].nil?
        found_values << @board[index][column][0]
      end
    end

    #compute column
    9.times do |index|
      if  @board[row][index].length == 1 && !@board[row][index][0].nil?
        found_values << @board[row][index][0]
      end
    end

    found_values
  end

end
