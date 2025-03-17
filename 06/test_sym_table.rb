# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'sym_table'

class SymTableTest < Minitest::Test
  def test_builtin
    sym_table = SymTable.new

    assert_equal 0, sym_table.key('@R0')
  end

  def test_setting_key
    sym_table = SymTable.new

    assert_equal 16, sym_table.key('@hello')
    assert_equal 17, sym_table.key('@bye')
    assert_equal 16, sym_table.key('@hello')
    assert_equal 17, sym_table.key('@bye')
  end
end
