#!/usr/bin/env ruby

def instructions
  @instructions ||= STDIN.read.split("\n").map(&:split)
end

@acc = 0
@pointer = 0
@executed = Hash.new(0)

def run_next(variation)
  instruction, arg = variation[@pointer]
  @executed[@pointer] = @executed[@pointer] + 1
  case instruction
  when "acc"
    @acc += arg.to_i
    @pointer += 1
  when "nop"
    # do nothing
    @pointer += 1
  when "jmp"
    @pointer += arg.to_i
  end
end

THRESHOLD = 1

def check_for_infinite_loops(variation)
  @acc = 0
  @pointer = 0
  @executed = Hash.new(0)
  loop do
    if @pointer >= variation.count
      return false
    elsif @executed[@pointer] > THRESHOLD
      return true
    else
      run_next(variation)
    end
  end
end

def variations
  @variations ||= instructions.each_with_index.map do |(cmd, arg), i|
    new_cmd = "nop" if cmd == "jmp"
    new_cmd = "jmp" if cmd == "nop"
    variation = instructions.clone
    variation[i] = [new_cmd, arg]
    variation = nil if cmd == "acc"
    variation
  end.compact
end

if __FILE__ == $0
  variations.each do |variation|
    unless check_for_infinite_loops(variation)
      p @acc
      break
    end
  end
end
