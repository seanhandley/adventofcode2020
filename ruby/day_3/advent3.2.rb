#!/usr/bin/env ruby

require_relative "./advent3.1"

if __FILE__ == $0
  puts [
    go(1, 1),
    go(3, 1),
    go(5, 1),
    go(7, 1),
    go(1, 2),
  ].reduce(:*)
end
