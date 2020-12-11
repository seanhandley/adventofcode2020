#!/usr/bin/env ruby

require_relative "./advent11.1"

def min_occupied
  5
end

def first_seat(seats, x, y, x_offset, y_offset)
  loop do
    x += x_offset
    y += y_offset
    return nil if out_of_bounds?(seats, x, y)
    return seats[y][x] if seats[y][x] != "."
  end
end

def neighbours(seats, x, y)
  direction_offsets.each_with_object([]) do |(x_offset, y_offset), n|
    n << first_seat(seats, x, y, x_offset, y_offset)
  end.compact.group_by { |g| g }
end

if __FILE__ == $0
  p run
end
