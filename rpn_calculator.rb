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
end
