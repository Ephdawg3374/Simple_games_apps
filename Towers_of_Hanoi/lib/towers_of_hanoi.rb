# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

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
