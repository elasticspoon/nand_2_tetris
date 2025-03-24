# frozen_string_literal: true

require_relative './sym_table'
require_relative './c_inst'
require_relative './assm_symbol'

class Assembler
  LOOP_DEC_REGEX = /\(([A-Z0-9_]+)\)/.freeze

  def initialize
    @sym_table = SymTable.new
    @prev_line = -1
  end

  def parse(file_contents, outfile)
    file = File.new(outfile, 'w')

    lines = file_contents.split("\n")

    insts = lines.filter_map do |line|
      line = line.gsub(%r{//.*}, '').gsub(' ', '')
      next nil if line.empty?

      if label?(line)
        label_name = line.match(LOOP_DEC_REGEX)[1]
        @sym_table.set(label_name, @prev_line + 1)
        next nil
      end

      @prev_line += 1
      line
    end

    insts.each do |line|
      ins = AssmSymbol.a_inst?(line) ? AssmSymbol.new(line, @sym_table, @prev_line) : CInst.new(line)
      file.puts ins.hack_instruction
    end
  ensure
    file.close
  end

  def label?(line)
    line.match?(LOOP_DEC_REGEX)
  end
end

input = ARGV[0]
Assembler.new.parse(File.read(input), input.gsub('.asm', '.hack'))
