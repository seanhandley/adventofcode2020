#!/usr/bin/env ruby

def passports
  @passports ||= STDIN.read.split("\n\n").map(&method(:parse_passport))
end

def parse_passport(passport)
  passport.split.each_with_object({}) do |e, obj|
    k, v = e.split(":")
    obj[k] = v
  end
end

def required_fields
  %w(byr iyr eyr hgt hcl ecl pid)
end

def required_fields_present?(passport)
  required_fields.all? { |key| passport.keys.include?(key) }
end

if __FILE__ == $0
  p passports.select(&method(:required_fields_present?)).count
end
