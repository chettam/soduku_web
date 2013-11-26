class User

	attr_reader :grid
	attr_accessor :unsolved_grid

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

	def create_unsolved_grid
		@unsolved_grid = Grid.new
		@unsolved_grid.create(grid.to_s)
		@unsolved_grid.cells.each { |cell| cell.unsolve! if rand(50).odd?}
	end



end