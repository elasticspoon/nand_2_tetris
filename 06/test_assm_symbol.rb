# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'assm_symbol'

class AssmSymbolTest < Minitest::Test
  def test_hack_instruction
    want = '0000000000000000'

    got = AssmSymbol.new('@R0').hack_instruction

    assert_equal want, got
  end
end
