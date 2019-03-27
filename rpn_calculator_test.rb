require_relative 'rpn_calculator'
require 'minitest/autorun'
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

  def test_two_operand_one_operator_expression_evaluation
    assert_equal 13.0, RpnCalculator.evaluate('5 8 +')
    assert_equal -3.0, RpnCalculator.evaluate('5 8 -')
    assert_equal 6.0, RpnCalculator.evaluate('-3 -2 *')
    assert_equal 1.5, RpnCalculator.evaluate('-3 -2 /')
  end

end
