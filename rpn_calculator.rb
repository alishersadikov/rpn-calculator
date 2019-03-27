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
        operand_1, operand_2 = stack.pop(2)
        stack.push(operand_1.send(item, operand_2))
      end
    end

    stack.last
  end
end
