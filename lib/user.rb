class User

	attr_reader :grid

	def initialize
		@grid = make_random_grid
	end

	def make_random_grid
	puzzle = (1..9).to_a.shuffle + Array.new(81-9,0)
	sudoku = Grid.new
	sudoku.create(puzzle.join)
	sudoku.solve
	sudoku
	end

end