#!/usr/bin/env ruby

SIZE = 20
@x = @y = @z = SIZE / 2

@grid = Array.new(SIZE) { Array.new(SIZE) { Array.new(SIZE) { "." } } }

def cycle
  
end

def active_count
  @grid.flatten.select { |c| c == "#" }.count
end

if __FILE__ == $0
  # 6.times { cycle }
  # p active_count
  puts "0"
end
