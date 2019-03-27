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

  def test_three_operand_one_operator_expression_evaluation
    assert_equal -5.0, RpnCalculator.evaluate('5 9 1 -')
    assert_equal 15.0, RpnCalculator.evaluate('5 9 1 +')
    assert_equal 45.0, RpnCalculator.evaluate('5 9 1 *')
    assert_equal 1.0, RpnCalculator.evaluate('6 3 2 /')
  end

  def test_three_operand_two_operator_expression_evaluation
    assert_equal 11.0, RpnCalculator.evaluate('-3 -2 * 5 +')
    assert_equal -0.625, RpnCalculator.evaluate('5 9 1 - 8 /')
    assert_equal 2.0, RpnCalculator.evaluate('2 3 5 * 15 /')
    assert_equal 10.0, RpnCalculator.evaluate('12 4 3 / 10 *')
  end

  def test_multiple_operand_multiple_operator_expression_evaluation
    assert_equal 3.0, RpnCalculator.evaluate('1 2 3 4 5 6 * 12 15 / 2 3 + 3 /')
    assert_equal 11.0, RpnCalculator.evaluate('12 15 * 5 3 / 11 14 + 26 -')
    assert_equal 1.0, RpnCalculator.evaluate('-1 2 3 4 5 6 * -12 -15 / 2 5 + 3 /')
  end
end
