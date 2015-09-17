class Board
	attr_reader :grid

	def initialize(grid = Array.new(3) { Array.new(3) })
		@grid = grid
	end

	def display_board
		@grid.each { |row| print "#{row}\n"}
	end

	def place_mark(pos, mark)
		raise "Error, mark has already been placed at #{pos}" if not empty?(pos)

		@grid[pos[0]][pos[1]] = mark

		display_board
	end

	def empty?(pos)
		(@grid[pos[0]][pos[1]].nil? or @grid[pos[0]][pos[1]].empty?) ? true : false
	end

	def winner
		# check row wins
		@grid.each do |row|
			if row.all? { |x| x == :X }
				return :X
			elsif row.all? {|x| x == :O}
				return :O
			end
		end

		# check col wins
		@grid.transpose.each do |col|
			if col.all? { |x| x == :X }
				return :X
			elsif col.all? { |x| x == :O }
				return :O
			end
		end

		# check diag wins
		diag_1 = Array.new
		diag_2 = Array.new
		
		0.upto(grid.size - 1) do |index|
			diag_1 << @grid[index][index]
			diag_2 << @grid[grid.size - 1 - index][index]
		end

		return :X if (diag_1.all? {|x| x == :X} or diag_2.all? { |x| x == :X})
		return :O if (diag_1.all? {|x| x == :O} or diag_2.all? { |x| x == :O})

		# no winner
		nil
	end

	def over?
		return true if winner

		# check tie
		tied = true
		@grid.each {|row| tied = false if not row.all?}

		return true if tied

		false
	end

end