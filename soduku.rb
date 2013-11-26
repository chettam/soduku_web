require 'sinatra' # load sinatra
require_relative './lib/grid'
require_relative './lib/cell'


def random_soduku
	puzzle = (1..9).to_a.shuffle + Array.new(81-9,0)
	sudoku = Grid.new
	sudoku.create(puzzle.join)
	sudoku.solve
	sudoku.to_s
end


get '/' do # default route for our website
	@current_solution = random_soduku
	puts @current_solution
	erb :index
end