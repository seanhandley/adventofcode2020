#!/usr/bin/env ruby

def numbers
  @numbers ||= STDIN.read.split.map(&:to_i)
end

def previous_window(position)
  numbers[position - window_size, window_size]
end

def window_size
  25
end

def weak_number
  @weak_number ||= find_weak_number
end

def find_weak_number
  position = window_size
  loop do
    current = numbers[position]
    sums = previous_window(position).combination(2).map { |a, b| a + b }
    return current unless sums.include?(current)
    position += 1
  end
end

if __FILE__ == $0
  p weak_number
end
