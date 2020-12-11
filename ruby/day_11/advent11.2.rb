#!/usr/bin/env ruby

require_relative "./advent11.1"

def min_occupied
  5
end

def first_seat(seats, x, y, x_offset, y_offset)
  max_x = seats.first.count
  max_y = seats.count
  loop do
    x += x_offset
    y += y_offset
    return nil if x < 0
    return nil if y < 0
    return nil if x >= max_x
    return nil if y >= max_y
    return seats[y][x] if seats[y][x] != "."
  end
end

def neighbours(seats, x, y)
  n = []
  n << first_seat(seats, x, y, -1,  0)
  n << first_seat(seats, x, y, +1,  0)
  n << first_seat(seats, x, y,  0, -1)
  n << first_seat(seats, x, y,  0, +1)
  n << first_seat(seats, x, y, -1, -1)
  n << first_seat(seats, x, y, -1, +1)
  n << first_seat(seats, x, y, +1, -1)
  n << first_seat(seats, x, y, +1, +1)
  n.compact.group_by { |g| g }
end

if __FILE__ == $0
  p run
end
