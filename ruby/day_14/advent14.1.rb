#!/usr/bin/env ruby

@memory = Hash.new(0)
@zero_mask, @one_mask = 0, 0

def instructions
  @instructions ||= STDIN.readlines.map(&method(:parse))
end

def parse(line)
  if line.start_with?("mask")
    line.split(" = ").map(&:strip)
  else
    ["mem", /mem\[(\d+)\] = (\d+)/.match(line).to_a[1..].map(&:to_i)]
  end
end

def execute
  instructions.each do |command, args|
    case command
    when "mask"
      @zero_mask = args.gsub("X", "1").to_i(2)
      @one_mask  = args.gsub("X", "0").to_i(2)
    when "mem"
      loc, val = args
      @memory[loc] = val & @zero_mask | @one_mask
    end
  end
end

if __FILE__ == $0
  execute
  p @memory.values.sum
end
