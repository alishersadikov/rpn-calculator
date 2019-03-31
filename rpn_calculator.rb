class RpnCalculator
  OPERATORS = %w[ + - * / ]

  def initialize(expression)
    @expression = expression
    @stack = []
  end

  def valid_operator?(value)
    OPERATORS.include?(value)
  end

  def valid_operand?(value)
    /\A[+-]?\d+(\.[\d]+)?\z/.match(value)
  end

  def evaluate
    validate_expression!

    @expression.split.each do |item|
      next @stack.push(item.to_f)         if valid_operand?(item)
      next perform_single_operation(item) if valid_operator?(item)
      raise ParseError
    end

    solution
  end

  private

  def perform_single_operation(operator)
    raise InvalidArityError if @stack.size < 2
    operand_1, operand_2 = @stack.pop(2)
    @stack.push(operand_1.send(operator, operand_2))
  end

  def validate_expression!
    raise InvalidExpressionError if @expression.nil? || @expression.length < 3
  end

  def solution
    raise InvalidExpressionError if @stack.size > 1
    @stack.last
  end
end

class InvalidExpressionError < StandardError; end
class InvalidArityError < StandardError; end
class ParseError < StandardError; end
