#!/usr/bin/env ruby

require_relative "./advent4.1"

def birth_year_valid?(year)
  year >= 1920 && year <= 2002
end

def issue_year_valid?(year)
  year >= 2010 && year <= 2020
end

def expiry_year_valid?(year)
  year >= 2020 && year <= 2030
end

def height_valid?(height)
  return false unless height =~ /(\d+)(cm|in)/

  match = height.match(%r((?<number>\d+)(?<unit>(cm|in))))

  if match[:unit] == "cm"
    match[:number].to_i >= 150 && match[:number].to_i <= 193
  elsif match[:unit] == "in"
    match[:number].to_i >= 59 && match[:number].to_i <= 76
  end
end

def hair_color_valid?(hair_color)
  hair_color =~ /\A#[a-f0-9]{6}\z/
end

def eye_color_valid?(eye_color)
  %w(amb blu brn gry grn hzl oth).include?(eye_color)
end

def passport_id_valid?(passport_id)
  passport_id.length == 9 && passport_id =~ /\d{9}/
end

def required_fields_valid?(passport)
  return false unless birth_year_valid?(passport["byr"].to_i)
  return false unless issue_year_valid?(passport["iyr"].to_i)
  return false unless expiry_year_valid?(passport["eyr"].to_i)
  return false unless height_valid?(passport["hgt"])
  return false unless hair_color_valid?(passport["hcl"])
  return false unless eye_color_valid?(passport["ecl"])
  return false unless passport_id_valid?(passport["pid"])

  true
end

def required_fields_present_and_valid?(passport)
  required_fields_present?(passport) && required_fields_valid?(passport)
end

if __FILE__ == $0
  p passports.select(&method(:required_fields_present_and_valid?)).count
end
