#!/usr/bin/env ruby

require_relative "./advent5.1"

def find_seat
  seat_ids.sort.each_cons(2) do |a, b|
    return a + 1 unless b - a == 1
  end
end

if __FILE__ == $0
  puts find_seat
end
