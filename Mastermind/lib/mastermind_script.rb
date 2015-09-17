#!/usr/bin/env ruby

require_relative 'mastermind'

if __FILE__ == $PROGRAM_NAME
	
	game = Game.new

	game.play
end