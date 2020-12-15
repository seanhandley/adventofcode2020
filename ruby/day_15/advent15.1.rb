#!/usr/bin/env ruby

@spoken = {}
@last, @count = 0, 0

def input
  @input ||= STDIN.read.split(",").map(&:to_i)
end

def add_spoken(n)
  e = @spoken[n]
  [@count, e ? e.first : @count].compact.tap do |previous|
    @spoken[n] = previous
    @last = n
    @count += 1
  end
end

def play_round(previous)
  add_spoken(previous.reduce(:-))
end

def play(target)
  previous = input.map(&method(:add_spoken)).last
  (target - @count).times { previous = play_round(previous) }
  @last
end

if __FILE__ == $0
  p play(2020)
end
