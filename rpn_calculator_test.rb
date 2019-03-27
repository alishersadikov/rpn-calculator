require 'minitest/autorun'
require_relative 'rpn_calculator'
require 'pry'

class RpnCalculatorTest < Minitest::Test
  def test_valid_operators
    assert_equal %w[ + - * / ], RpnCalculator.operators
    assert RpnCalculator.valid_operator?('+')
    refute RpnCalculator.valid_operator?('**')
  end

  def test_valid_operands
    assert RpnCalculator.valid_operand?('-13')
    assert RpnCalculator.valid_operand?('0')
    assert RpnCalculator.valid_operand?('13')
  end

  def test_invalid_operands
    refute RpnCalculator.valid_operand?('A')
    refute RpnCalculator.valid_operand?('13A')
  end

  def test_operators_are_invalid_as_operands
    RpnCalculator.operators.each do |operator|
      refute RpnCalculator.valid_operand?(operator)
    end
  end
end
