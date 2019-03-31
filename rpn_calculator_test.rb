require_relative 'rpn_calculator'
require 'minitest/autorun'

class RpnCalculatorTest < Minitest::Test
  def rpn(expression)
    RpnCalculator.new(expression)
  end

  def test_valid_operators
    assert_equal %w[ + - * / ], RpnCalculator::OPERATORS
    assert rpn('5 8 +').valid_operator?('+')
    refute rpn('5 8 **').valid_operator?('**')
  end

  def test_valid_operands
    assert rpn('5 -13 +').valid_operand?('-13')
    assert rpn('0 5 *').valid_operand?('0')
    assert rpn('5 13 -').valid_operand?('13')
  end

  def test_invalid_operands
    refute rpn('A B C').valid_operand?('A')
    refute rpn('13A 13B').valid_operand?('13A')
  end

  def test_operators_are_invalid_as_operands
    RpnCalculator::OPERATORS.each do |operator|
      refute rpn('test').valid_operand?(operator)
    end
  end

  def test_two_operand_one_operator_expression_evaluation
    assert_equal 13.0, rpn('5 8 +').evaluate
    assert_equal -3.0, rpn('5 8 -').evaluate
    assert_equal 6.0, rpn('-3 -2 *').evaluate
    assert_equal 1.5, rpn('-3 -2 /').evaluate
  end

  def test_three_operand_two_operator_expression_evaluation
    assert_equal 5.0, rpn('3 2 - 5 *').evaluate
    assert_equal 11.0, rpn('-3 -2 * 5 +').evaluate
    assert_equal 0.625, rpn('5 9 1 - /').evaluate
    assert_equal 2.0, rpn('30 3 5 * /').evaluate
    assert_equal 16.0, rpn('4 12 3 / *').evaluate
  end

  def test_multiple_operand_multiple_operator_expression_evaluation
    assert_equal 3.0, rpn('6 6 * 12 / 3 + 2 /').evaluate
    assert_equal 25.0, rpn('12 15 * 5 / 14 + 25 -').evaluate
    assert_equal 4.0, rpn('-12 5 * -15 / 8 + 3 /').evaluate
  end

  def test_invalid_expression
    ['5 9 1 -', '5 9 1 - 8 /', '1 2 3 4 6 * 12 15 / 2 3 + 3 /', '+', '', nil].each do |invalid_expression|
      assert_raises InvalidExpressionError do
        rpn(invalid_expression).evaluate
      end
    end
  end

  def test_invalid_number_of_operands
    ['5 + 8', '+ 5 8', '5 + 6 -'].each do |invalid_expression|
      assert_raises InvalidArityError do
         rpn(invalid_expression).evaluate
      end
    end
  end

  def test_invalid_input_parse_error
    ['5 8 !', '5 8 &', '5 8 %'].each do |invalid_expression|
      assert_raises ParseError do
         rpn(invalid_expression).evaluate
      end
    end
  end
end
