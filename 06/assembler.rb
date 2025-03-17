# frozen_string_literal: true

require_relative './sym_table'
require_relative './c_inst'
require_relative './assm_symbol'

class Assembler
  LOOP_DEC_REGEX = /\(([A-Z]+)\)/.freeze

  def initialize
    @sym_table = SymTable.new
    @prev_line = -1
  end

  def parse(file_contents)
    file_contents.split("\n").filter_map do |line|
      line = line.gsub(%r{//.*}, '').gsub(' ', '')
      next if line.empty?

      if label?(line)
        label_name = line.match(LOOP_DEC_REGEX)[1]
        @sym_table.set(label_name, @prev_line + 1)
        next nil
      end

      @prev_line += 1
      ins = AssmSymbol.a_inst?(line) ? AssmSymbol.new(line, @sym_table, @prev_line) : CInst.new(line)
      # puts "#{@prev_line} #{line} #{ins.hack_instruction}"
      puts ins.hack_instruction
    end
  end

  def label?(line)
    line.match?(LOOP_DEC_REGEX)
  end
end

Assembler.new.parse(File.read('./06/test.asm'))
