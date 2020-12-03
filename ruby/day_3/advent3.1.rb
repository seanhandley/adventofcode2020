#!/usr/bin/env ruby

def map
  @map ||= STDIN.read.split("\n").map(&:chars)
end

MAX_WIDTH  = map.first.length
MAX_HEIGHT = map.length
TREE       = "#".freeze

def go(x_step, y_step)
  x         = 0
  y         = 0
  trees     = 0

  while y < MAX_HEIGHT
    if map[y][x] == TREE
      trees += 1
    end
    x = (x + x_step) % MAX_WIDTH
    y += y_step
  end

  trees
end

if __FILE__ == $0
  puts go(3, 1)
end
