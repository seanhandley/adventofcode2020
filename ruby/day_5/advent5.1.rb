#!/usr/bin/env ruby

def passes
  @passes ||= STDIN.read.split.map(&:chars)
end

def resolve_position(directions, lowest, highest, lower_end)
  directions.each do |direction|
    halfway = ((highest - lowest) / 2.0).ceil
    if direction == lower_end
      highest -= halfway
    else
      lowest += halfway
    end
  end
  lowest
end

def seat_ids
  @seat_ids ||= passes.map do |pass|
    row = resolve_position(pass.first(7), 0, 127, "F")
    col = resolve_position(pass.last(3),  0, 7,   "L")

    row * 8 + col
  end
end

if __FILE__ == $0
  p seat_ids.max
end
