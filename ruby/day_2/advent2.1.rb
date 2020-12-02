#!/usr/bin/env ruby

def passwords
  @passwords ||= STDIN.read.split("\n").map do |password|
    a, b, c = password.split
    {
      minimum: a.split("-").first.to_i,
      maximum: a.split("-").last.to_i,
      letter: b.chars.first,
      password: c
    }
  end
end

def count_valid_passwords
  passwords.select do |entry|
    count = entry[:password].chars.group_by { |a| a }[entry[:letter]]&.count
    count = count.to_i
    count >= entry[:minimum] && count <= entry[:maximum]
  end.count
end

if __FILE__ == $0
  p count_valid_passwords
end
