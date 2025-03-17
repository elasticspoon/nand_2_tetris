# frozen_string_literal: true

class AssmSymbol
  A_INST_REGEX = /@(\S+)/.freeze

  attr_reader :symbol

  def initialize(symbol, sym_table, prev_inst_num)
    @symbol = symbol
    @sym_table = sym_table
    @prev_inst_num = prev_inst_num
  end

  def self.a_inst?(line)
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

  def hack_instruction
    format('%016b', symbol_code)
  end
end
