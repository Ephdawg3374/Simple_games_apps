require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
	attr_reader :board, :player_one, :player_two, :current_player

	def initialize(player_one, player_two)
		@board = Board.new
		@player_one = player_one
		@player_two = player_two
		@current_player = @player_one

		@player_one.mark = :X if @player_one.mark.nil?
		@player_two.mark = :O if (@player_two.mark.nil? or @player_one.mark == :X)
	end

	def switch_players!
		if @current_player == @player_one
			@current_player = @player_two
		else
			@current_player = @player_one
		end
	end

	def play_turn
		@current_player.display(@board)

		move = @current_player.get_move

		@board.place_mark(move, @current_player.mark)

		puts "#{@current_player} has made a move!"

		puts "Congrats #{@current_player}, you won!" if @board.winner == @current_player.mark

		switch_players!

		rescue Exception => e
			puts e.message
			play_turn
	end

	def play
		loop do
			play_turn
			if @board.over?
				puts "Game over!"
				puts "Game is tied! You all blow chunks!!" if @board.winner.nil?
				break
			end
		end
	end

end
