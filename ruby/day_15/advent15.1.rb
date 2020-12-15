#!/usr/bin/env ruby

@spoken = {}
@last = 0
@count = 0

def input
  @input ||= STDIN.read.split(",").map(&:to_i)
end

def add_spoken(n)
  @spoken[n] = [@count, @spoken[n]&.first].compact
  @last = n
  @count += 1
end

def play_round
  previous_examples = @spoken[@last]

  if previous_examples.count == 1
    add_spoken(0)
  else
    add_spoken(previous_examples.reduce(:-))
  end
end

def play(target)
  input.each(&method(:add_spoken))
  (target - @count).times { play_round }
  @last
end

if __FILE__ == $0
  p play(2020)
end
