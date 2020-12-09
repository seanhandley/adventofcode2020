#!/usr/bin/env ruby

require_relative "./advent9.1"

def contiguous_set
  @contiguous_set ||= find_contiguous_set
end

def find_contiguous_set
  set_size = 2
  loop do
    numbers.each_cons(set_size).each do |n|
      return n if n.sum == weak_number
    end
    set_size += 1
  end
end

if __FILE__ == $0
  p [contiguous_set.min, contiguous_set.max].sum
end
