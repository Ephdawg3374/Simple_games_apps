require 'byebug'

class RPNCalculator
	attr_reader :values
	def initialize
		@values = []
	end

	def value
		@values.last
	end

	def push(num)
		@values << num
	end

	def plus
		perform_operation(:+)
	end

	def minus
		perform_operation(:-)
	end

	def divide
		perform_operation(:/)
	end

	def times
		perform_operation(:*)
	end

	def perform_operation(operation)
		raise Exception.new("calculator is empty") if (@values.size < 2)

		right_num = @values.pop
		left_num = @values.pop

		case operation
		when :+; @values << left_num + right_num
		when :-; @values << left_num - right_num
		when :/; @values << left_num.to_f / right_num
		when :*; @values << left_num * right_num
		else; raise "invalid operator"
		end
	end

	def tokens(str)
		str.strip.split.map! { |i| i[/\d/]? i.to_i : i.to_sym }
	end
=begin
	def hash_of_tokens(tokens)
		result = Hash.new
		pos = 0
		arr_id = 0

		for i in 0...tokens.size
			if tokens[i].class == Symbol and (tokens[i+1].class == Fixnum or i == tokens.size - 1)
				result[arr_id] = tokens[pos..i]
				arr_id += 1
				pos = i + 1
			end
		end
		result
	end

	def add_values(tokens)
		tokens.each { |x| push(x) if x.class == Fixnum }
	end
=end
	def evaluate(str)
		# reset instance variables
		@value = nil
		@values = []

		tokenized = tokens(str)
		#debugger
		tokenized.each do |token|
			if token.class == Fixnum
				push(token)
			elsif token.class == Symbol
				perform_operation(token)
			end
		end

		value
	end

	def user_interface
		user_input = Array.new

		puts "Enter numbers and operands:"

		loop do
			input = $stdin.gets.chomp
			break if input.empty?
			user_input << input
			puts "Current numbers and operands: #{user_input}"
		end

		puts "Your calculation evaluated to #{evaluate(user_input.join(" "))}. Thank you for using Ephraim's RPN Calculator!"

	end

	def run_calc_with_file(file)
		counter = 1

		File.foreach(file) do |line|
			puts "Your answer to case #{counter}: #{evaluate(line.chomp)}"
			counter += 1
		end
	end

end
