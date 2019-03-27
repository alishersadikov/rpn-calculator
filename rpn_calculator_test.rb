require 'minitest/autorun'
require_relative 'rpn_calculator'

class RpnCalculatorTest < Minitest::Test
  def test_operators_list
    assert_equal %w[ + - * /], RpnCalculator.valid_operators
  end
end
