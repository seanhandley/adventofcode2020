#!/usr/bin/env ruby

def passwords
  @passwords ||= STDIN.read.split("\n").map do |password|
    a, b, c = password.split
    {
      position_1: a.split("-").first.to_i,
      position_2: a.split("-").last.to_i,
      letter: b.chars.first,
      password: c
    }
  end
end

def count_valid_passwords
  passwords.select do |entry|
    (entry[:password][entry[:position_1] - 1] == entry[:letter]) ^
      (entry[:password][entry[:position_2] - 1] == entry[:letter])
  end.count
end

if __FILE__ == $0
  p count_valid_passwords
end
