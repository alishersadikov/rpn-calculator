module RpnCalculator
  extend self

  def operators
    %w[ + - * / ]
  end

  def valid_operator?(value)
    operators.include?(value)
  end

  def valid_operand?(value)
    /\A[+-]?\d+(\.[\d]+)?\z/.match(value)
  end

  def evaluate(expression)
    raise InvalidExpressionError if expression.nil? || expression.length < 3

    stack = []

    expression.split.each do |item|

      if valid_operand?(item)
        stack.push(item.to_f)
      elsif valid_operator?(item)
        raise InvalidArityError if stack.size < 2
        stack = [stack.reduce(item)]
      else
        raise ExpressionParseError
      end

    end

    stack.last
  end
end

class InvalidExpressionError < StandardError; end
class InvalidArityError < StandardError; end
class ExpressionParseError < StandardError; end
