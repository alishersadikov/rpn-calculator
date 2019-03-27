require_relative 'rpn_calculator'

puts "Welcome to RPN Calculator REPL!"
@expression = []

def handle_input(input)
  puts (" => #{input}")
  @expression << input

  puts parse if RpnCalculator::OPERATORS.include?(input)
end

def parse
  RpnCalculator.new(@expression.join(' ')).evaluate
rescue => e
  @expression = []
  e.message # STDERR output also makes sense here
end

loop do
  print '>> '
  input = gets.chomp
  break if input == 'q'
  handle_input(input)
end
