#!/usr/bin/env ruby

# --- Part Two ---
# Ding! The "fasten seat belt" signs have turned on. Time to find your seat.
#
# It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.
#
# Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.
#
# What is the ID of your seat?

require_relative "./advent5.1"

def find_seat
  seat_ids.sort.each_cons(2).detect { |a, b| b - a == 2 }.first + 1
end

if __FILE__ == $0
  puts find_seat
end
