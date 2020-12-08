#!/usr/bin/env ruby

def instructions
  @instructions ||= STDIN.read.split("\n").map(&:split)
end

@acc = 0
@pointer = 0
@executed = Hash.new(0)

def run_next
  instruction, arg = instructions[@pointer]
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

if __FILE__ == $0
  loop do
    if @executed[@pointer] > 0
      puts @acc
      break
    else
      run_next
    end
  end
end
