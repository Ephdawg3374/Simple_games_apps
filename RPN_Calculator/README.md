# Reverse Polish Notation (RPN) Calculator with optional I/O

"RPN" stands for "Reverse Polish Notation". (See [the wikipedia
entry](http://en.wikipedia.org/wiki/Reverse_Polish_notation) for
more information on this colorful term.) Briefly, in an RPN world,
instead of using normal "infix" notation, e.g.

   	* 2 + 2

you use "postfix" notation, e.g.

		* 2 2 +

While this may seem bizarre, there are some advantages to doing
things this way. For one, you never need to use parentheses, since
there is never any ambiguity as to what order to perform operations
in. The rule is, you always go from the back, or the left side.

    * 1 + 2 * 3 =>
		* (1 + 2) * 3 or
		* 1 + (2 * 3)

		* 1 2 + 3 * => (1 + 2) * 3
		* 1 2 3 * + => 1 + (2 * 3)

If using the calculator with file input, please make sure the file follows
the following format:

filename = calculator_instructions.txt
5 2 + 4 *
1 2 * 1 +

RPN Calculator has two modes
1.) File input
2.) User interface

To use with file input, navigate to root directory and run "rpn_calculator_script.rb" 
with the argument "calculator_instructions.txt".

To use the user interface (can type your own calculations), run the same script WITHOUT any arguments.

User interface that reads from standard input one operand or operator at a time. If the user
hits `enter` with no operand, the calculator should run and output its result.

```
~$ ruby 12_rpn_calculator.rb
5
2
+
4
*
result = 28