class TowersOfHanoi
	attr_reader :towers, :number_of_moves

	def initialize
		@towers = [[3,2,1], [], []]
		@number_of_moves = 0
	end

	def play
		finished = false

		while not finished

			valid_move = false

			while not valid_move
				render

			begin
				puts "Which tower will you select the disc from (choose from 0 to 2)?"
				from_tower = gets.chomp.to_i

				puts "Which tower will you move the disc to (choose from 0 to 2)?"
				to_tower = gets.chomp.to_i

				valid_move = valid_move?(from_tower, to_tower)
				valid_move ==  true ? move(from_tower, to_tower) : puts("Invalid move, please make another move.")
			rescue
				puts "Invalid move"
			end

			end

			finished = won?

			puts "Congrats!! You beat the game!!!!! Cookies for you! Number of moves made: #{number_of_moves}" if finished
		end
	end

	def valid_move?(from_tower, to_tower)
		# Rules of the game:
		# 1.) Only one disk can be moved at a time.
		# 2.) Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack
		# 3.) No disk may be placed on top of a smaller disk.
		return false if @towers[from_tower].empty?

		if @towers[to_tower].empty?
			true
		else
			@towers[from_tower].last < @towers[to_tower].last ? true : false
		end

	end

	def move(from_tower, to_tower)
		@towers[to_tower] << @towers[from_tower].pop
		@number_of_moves += 1
	end

	def won?
		@towers[1] == [3,2,1] or @towers[2] == [3,2,1]? true : false
	end

	def render
		2.downto(0) do |index|
			(@towers[0][index].nil? or @towers[0].empty?) ? tower_0_render = "| |" : tower_0_render = "|#{@towers[0][index]}|"

			(@towers[1][index].nil? or @towers[1].empty?) ? tower_1_render = "| |" : tower_1_render = "|#{@towers[1][index]}|"

			(@towers[2][index].nil? or @towers[2].empty?) ? tower_2_render = "| |" : tower_2_render = "|#{@towers[2][index]}|"
			
			puts "#{tower_0_render} #{tower_1_render} #{tower_2_render}"
		end
	end

end
