# frozen_string_literal: true

class HackIns
  A_INST_REGEX = /@(\S+)/.freeze
  LOOP_DEC_REGEX = /\(([A-Z]+)\)/.freeze
  JUMP_MAP = {
    nil => '000',
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '100',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111'
  }.freeze

  ALU_MAP = {
    '0' => '0101010',
    '1' => '0111111',
    '-1' => '0111010',
    'D' => '0001100',
    'A' => '0110000',
    'M' => '1110000',
    '!D' => '0001101',
    '!A' => '0110001',
    '!M' => '1110001',
    '-D' => '0001111',
    '-A' => '0110011',
    'D+1' => '0011111',
    'A+1' => '0110111',
    'M+1' => '1110111',
    'D-1' => '0001110',
    'A-1' => '0110010',
    'M-1' => '1110010',
    'D+M' => '1000010',
    'D+A' => '0000010',
    'D-M' => '1010011',
    'D-A' => '0010011',
    'A-D' => '0000111',
    'M-D' => '1000111',
    'D&A' => '0000000',
    'D&M' => '1000000',
    'D|A' => '0010101',
    'D|M' => '1010101'
  }.freeze

  attr_reader :line

  def initialize(line, sym_table, prev_inst_num)
    @line = line
    @sym_table = sym_table
    @prev_inst_num = prev_inst_num
  end

  def a_inst?
    line.match?(A_INST_REGEX)
  end

  def symbol_code
    raise "invalid symbol '#{symbol}'" unless symbol.match?(A_INST_REGEX)

    sym = symbol.match(A_INST_REGEX)[1]
    int?(sym) ? Integer(sym) : @sym_table.key(sym)
  end

  def int?(val)
    val.to_i.to_s == val
  end

  def parse_c_inst; end

  def hack_instruction
    a_inst? ? format('%016b', symbol_code) : parse_c_inst
  end

  def leading_bits
    '111'
  end

  def dest_bits
    tally = (set_inst || '').chars.tally
    has_invalid_keys = (tally.keys - %w[A M D]).any?
    has_invalid_count = tally.values.any? { it > 1 }

    raise "invalid destination: '#{set_inst}'" if has_invalid_keys || has_invalid_count

    m_bit = tally['M'] ? '1' : '0'
    a_bit = tally['A'] ? '1' : '0'
    d_bit = tally['D'] ? '1' : '0'

    "#{a_bit}#{d_bit}#{m_bit}"
  end

  def jump_bits
    jump = JUMP_MAP[jump_inst]

    raise "invalid jump instruction: '#{jump_inst}'" if jump.nil?

    jump
  end

  def alu_bits
    alu = ALU_MAP[alu_inst]

    raise "invalid computation: '#{alu_inst}'" if alu.nil?

    alu
  end

  def parse_c_inst
    leading_bits + alu_bits + dest_bits + jump_bits
  end

  def decompose
    line
    @set_inst, line = line.split('=') if line.include?('=')
    line, @jump_inst = line.split(';') if line.include?(';')

    [@set_inst, line, @jump_inst]
  end
end
