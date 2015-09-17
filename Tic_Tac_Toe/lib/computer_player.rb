class ComputerPlayer
	attr_reader :name, :board, :x_or_o
	attr_accessor :mark

	def initialize(name)
		@name = name
	end

	def display(board)
		@board = board
	end

	def get_move
		# check for winning move
		# check row wins
		@board.grid.each_with_index do |row, index|
			return [index, row.index(nil)] if (row.count(@mark) == 2 and row.include?(nil))
		end

		# check col wins
		@board.grid.transpose.each_with_index do |col, index|
			return [col.index(nil), index] if (col.count(@mark) == 2 and col.include?(nil))
		end

		# check diag wins
		diag = Array.new(2) {Array.new}
		
		0.upto(@board.grid.size - 1) do |index|
			diag[0] << @board.grid[index][index]
			diag[1] << @board.grid[@board.grid.size - 1 - index][index]
		end

		return [diag[0].index(nil), diag[0].index(nil)] if (diag[0].count(@mark) == 2 and diag[0].include?(nil))
		return [(diag[1].size - diag[1].index(nil)), diag[1].index(nil)] if (diag[1].count(@mark) == 2 and diag[1].include?(nil))

		# no winning moves, return random move
		[rand(0...@board.grid.size), rand(0...@board.grid.size)]
	end
end
