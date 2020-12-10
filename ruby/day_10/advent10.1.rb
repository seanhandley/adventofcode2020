#!/usr/bin/env ruby

def jolts
  @jolts ||= STDIN.read.split.map(&:to_i).sort
end

def jolts_plus_device
  @jpd ||= [0] + jolts + [jolts.last + 3]
end

def differences
  jolts_plus_device.each_cons(2).map { |a, b| b - a }.group_by { |g| g }.map(&:last).map(&:count)
end

if __FILE__ == $0
  p differences.reduce(:*)
end
