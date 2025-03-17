# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'c_inst'

class CInstTest < Minitest::Test
  TEST_VALUES = {
    'M=1' => '1110111111001000',
    'M=0' => '1110101010001000',
    'D=M' => '1111110000010000',
    'D=D-M' => '1111010011010000',
    'M=D+M' => '1111000010001000',
    'M=M+1' => '1111110111001000',
    '0;JMP' => '1110101010000111',
    'D;JGT' => '1110001100000001'
  }

  def test_c_inst_conversion
    TEST_VALUES.each do |k, v|
      inst = CInst.new(k).hack_instruction
      assert_equal v, inst
    rescue StandardError => e
      puts "\nerror testing '#{k}'"
      raise e
    end
  end
end
