#!/usr/bin/env ruby

require_relative 'rpn_calculator'

if __FILE__ == $PROGRAM_NAME
	#puts "#{__FILE__} #{$PROGRAM_NAME}"
	#puts Dir.pwd
	calc = RPNCalculator.new

	if ARGV.empty?
		calc.user_interface
	else
		calc.run_calc_with_file(ARGV[0])
	end
end
