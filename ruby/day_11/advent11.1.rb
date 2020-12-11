#!/usr/bin/env ruby

def starting_seats
  @starting_seats ||= STDIN.read.split("\n").map(&:chars)
end

def direction_offsets
  @direction_offsets ||= [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]
end

def out_of_bounds?(seats, x, y)
  [x < 0, y < 0, x >= seats.first.count, y >= seats.count].any?
end

def neighbours(seats, x, y)
  direction_offsets.each_with_object([]) do |(offset_x, offset_y), n|
    unless out_of_bounds?(seats, x + offset_x, y + offset_y)
      n << seats.dig(y + offset_y, x + offset_x) 
    end
  end.compact.group_by { |g| g }
end

def min_occupied
  4
end

def step(seats)
  new_seats = Array.new(seats.length) { Array.new(seats.first.count) }
  seats.each_with_index do |row, y|
    row.each_with_index do |col, x|
      if col == "L"
        if neighbours(seats, x, y)["#"].nil?
          new_seats[y][x] = "#"
        else
          new_seats[y][x] = col
        end
      elsif col == "#"
        if neighbours(seats, x, y)["#"]&.count&.>=(min_occupied)
          new_seats[y][x] = "L"
        else
          new_seats[y][x] = col
        end
      else
        new_seats[y][x] = col
      end
    end
  end
  new_seats
end

def occupied_count(seats)
  seats.flatten.count { |seat| seat == "#" }
end

def run
  seats = starting_seats
  occupied = occupied_count(seats)
  loop do
    seats = step(seats)
    if occupied == occupied_count(seats)
      return occupied
    else
      occupied = occupied_count(seats)
    end
  end
end

if __FILE__ == $0
  p run
end
