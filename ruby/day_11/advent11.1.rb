#!/usr/bin/env ruby

def starting_seats
  @starting_seats ||= STDIN.read.split("\n").map(&:chars)
end

def neighbours(seats, x, y)
  max_x = seats.first.count
  max_y = seats.count
  n = []
  n << seats.dig(y, x - 1) if x > 0
  n << seats.dig(y, x + 1) if x < max_x
  n << seats.dig(y - 1, x) if y > 0
  n << seats.dig(y + 1, x) if y < max_y
  n << seats.dig(y - 1, x - 1) if x > 0 && y > 0
  n << seats.dig(y - 1, x + 1) if x < max_x && y > 0
  n << seats.dig(y + 1, x - 1) if y < max_y && x > 0
  n << seats.dig(y + 1, x + 1) if y < max_y && x < max_x
  n.compact.group_by { |g| g }
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
