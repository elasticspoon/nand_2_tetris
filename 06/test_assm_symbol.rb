# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'assm_symbol'

class AssmSymbolTest < Minitest::Test
  def test_predefined_inst
    want = '0000000000000000'

    got = AssmSymbol.new('@R0').hack_instruction

    assert_equal want, got
  end

  def test_a_inst_loc
    want = '0000000001000000'

    got = AssmSymbol.new('@64').hack_instruction

    assert_equal want, got
  end

  def test_a_inst_variable
    want = '0000000000010000'

    got = AssmSymbol.new('@test').hack_instruction

    assert_equal want, got
  end

  def test_a_two_inst_variables
    want = '0000000000010001'

    AssmSymbol.new('@test1').hack_instruction
    got = AssmSymbol.new('@test2').hack_instruction

    assert_equal want, got
  end
end
