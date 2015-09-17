require 'byebug'

class Code
  attr_reader :pegs

  PEGS = {
  		"r" => 0,
  		"g" => 1,
  		"b" => 2,
  		"y" => 3,
  		"o" => 4,
  		"p" => 5
  	}

  def initialize(pegs)
  	raise "You must initialize Code with a peg array." if not pegs

  	@pegs = pegs
  end

  def self.random
  	random_pegs = Array.new(4)

  	0.upto(3) { |index| random_pegs[index] = Code::PEGS.key(rand(0..5))}

  	Code.new(random_pegs)
  end

  def self.parse(user_input)
  	user_input = user_input.downcase

  	raise "Invalid input. Please guess again." if (user_input.length != 4 or (user_input =~ /[^rgbyop]/).nil? == false)

  	Code.new(user_input.split(""))
  end

  def [](index)
  	@pegs[index]
  end

  def exact_matches(code)
  	matches = 0

  	@pegs.each_with_index do |peg, index| 
  		matches += 1 if peg == code.pegs[index]
  	end

  	matches

  end

  def near_matches(code)
  	#debugger
  	near_matches = 0
  	pegs_to_check_against = code.pegs.dup

  	# remove exact matches from pegs to check against
  	if exact_matches(code) > 0
  		0.upto(3) { |index| pegs_to_check_against.delete_at(index) if @pegs[index] == code.pegs[index] }
  	end

  	@pegs.each_with_index do |peg, index|
  		next if peg == code.pegs[index]

  		if peg != code.pegs[index] and pegs_to_check_against.include?(peg)
  			near_matches += 1
  			pegs_to_check_against.delete_at(pegs_to_check_against.index(peg))
  		end
  	end

  	near_matches

  end

  def ==(code)
  	(code.class == Code and @pegs == code.pegs) ? true : false
  end

end

class Game
  attr_reader :secret_code, :number_of_turns

  def initialize(code = Code.random)
  	@secret_code = code
  	@number_of_turns = 0
  end

  def get_guess
  	Code.parse($stdin.gets.chomp)

		rescue Exception => e
			puts e.message
			get_guess
  end

  def display_matches(code)
  	puts "Number of exact matches: #{@secret_code.exact_matches(code)}"
  	puts "Number of near matches: #{@secret_code.near_matches(code)}"
  end

  def play
  	while @number_of_turns <= 10
  		puts "Number of turns remaining = #{10 - @number_of_turns}"
  		puts "Please guess a combination (ex: RGYP, not case sensitive)"
  		user_input = get_guess

  		if @secret_code == user_input
  			winner
  			break
  		end

  		puts "Not the correct answer!"
  		display_matches(user_input) if (@secret_code.exact_matches(user_input) > 0 or @secret_code.near_matches(user_input) > 0)

  		@number_of_turns += 1
  	end
  end

  def winner
  	puts "Congrats! You guess correctly!!"
  end

end
