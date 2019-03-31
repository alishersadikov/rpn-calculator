require_relative 'rpn_calculator'

puts "Welcome to the RPN Calculator REPL!"
puts "Enter c to calculate or q to quit."
puts "Enter the expression one element at a time or the whole expression:"

@expression = []

def handle_input(input)
  if input == 'c'
    return puts (" => #{evaluate!}")
  else
    puts (" => #{input}")
    @expression << input
  end
end

def evaluate!
  result = RpnCalculator.new(@expression.join(' ')).evaluate.to_s
  @expression = []
  result
rescue => e
  @expression = []
  e.message
end

loop do
  print '>> '
  input = gets.chomp
  break if input == 'q'
  handle_input(input)
end
