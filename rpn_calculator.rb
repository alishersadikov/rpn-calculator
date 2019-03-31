class RpnCalculator
  OPERATORS = %w[ + - * / % ** ! ]

  def initialize(expression)
    @expression = format_and_split(expression)
    @stack = []
  end

  def valid_operator?(value)
    OPERATORS.include?(value)
  end

  def valid_operand?(value)
    /\A[+-]?\d+(\.[\d]+)?\z/.match(value)
  end

  def evaluate
    @expression.each do |element|
      next @stack.push(element.to_f)         if valid_operand?(element)
      next perform_single_operation(element) if valid_operator?(element)
      raise ParseError
    end

    solution
  end

  private

  def format_and_split(raw_expression)
    raise InvalidExpressionError if raw_expression.nil?
    # a space is needed before exclamation mark to differentiate it
    # and to to mimic the behavior of the other operators
    raw_expression.gsub('!', ' !').split
  end

  def perform_single_operation(operator)
    # factorial should be enabled even for stack size of 1
    return handle_factorial if operator == '!'

    raise InvalidArityError if @stack.size < 2

    operand_1, operand_2 = @stack.pop(2)
    @stack.push(operand_1.send(operator, operand_2))
  end

  def handle_factorial
    @stack.push(calculate_factorial(@stack.pop.to_i))
  end

  def calculate_factorial(integer)
    # As factorial is not a built in Ruby operator, it is calculated manually:
    (1..integer).reduce(:*).to_f
  end

  def solution
    raise InvalidExpressionError if @stack.size > 1
    @stack.last
  end
end

class InvalidExpressionError < StandardError; end
class InvalidArityError < StandardError; end
class ParseError < StandardError; end
