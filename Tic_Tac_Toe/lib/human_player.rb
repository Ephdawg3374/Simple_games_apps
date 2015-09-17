class HumanPlayer
	attr_reader :name
	attr_accessor :mark

	def initialize(name)
		@name = name
	end

	def display(board)
		board.grid.each { |row| print "#{row}\n" }
	end

	def get_move
		puts "#{@name}, please enter position where you would like to put a mark."
		pos = $stdin.gets.chomp.split(",").map(&:to_i)
	end

end
