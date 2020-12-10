#!/usr/bin/env ruby

require_relative "./advent10.1"

def combinations
  jolts.each_with_object({ 0 => 1 }) do |jolt, counts|
    previous_three = 3.downto(1).map { |n| counts[jolt - n] }
    counts[jolt] = previous_three.compact.sum
  end
end

if __FILE__ == $0
  p combinations.values.max
end
