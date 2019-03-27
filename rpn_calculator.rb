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
    expression = expression.split
    stack = []

    expression.each do |item|
      if valid_operand?(item)
        stack.push(item.to_f)
      elsif valid_operator?(item)
        stack = [stack.reduce(item)]
      end
    end

    stack.last
  end
end
