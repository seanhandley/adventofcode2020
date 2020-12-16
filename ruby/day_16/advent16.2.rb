#!/usr/bin/env ruby

# --- Part Two ---
# Now that you've identified which tickets contain invalid values, discard those tickets entirely. Use the remaining valid tickets to determine which field is which.
#
# Using the valid ranges for each field, determine what order the fields appear on the tickets. The order is consistent between all tickets: if seat is the third field, it is the third field on every ticket, including your ticket.
#
# For example, suppose you have the following notes:
#
# class: 0-1 or 4-19
# row: 0-5 or 8-19
# seat: 0-13 or 16-19
#
# your ticket:
# 11,12,13
#
# nearby tickets:
# 3,9,18
# 15,1,5
# 5,14,9
#
# Based on the nearby tickets in the above example, the first position must be row, the second position must be class, and the third position must be seat; you can conclude that in your ticket, class is 12, row is 11, and seat is 13.
#
# Once you work out which field is which, look for the six fields on your ticket that start with the word departure. What do you get if you multiply those six values together?

require_relative "./advent16.1"

def valid_tickets
  @valid_tickets ||= nearby_tickets.reject do |ticket|
    ticket.any? { |val| invalid_for_all_fields?(val) }
  end
end

def valid_positions(ranges)
  (0...rules.count).select do |i|
    valid_tickets.all? do |ticket|
      ranges.any? { |range| range.cover?(ticket[i]) }
    end
  end
end

def all_valid_positions
  @all_valid_positions ||= rules.map do |name, ranges|
    [name, valid_positions(ranges)]
  end.sort_by { |_name, positions| positions.count }
end

def valid_ordering
  all_valid_positions.each_with_object({}) do |(field, positions), result|
    num = positions.first
    result[field] = num
    all_valid_positions.each { |_field, positions| positions.delete(num) }
  end
end

if __FILE__ == $0
  valid_ordering.
    sort_by(&:last).
    select { |field, _position| field.start_with?("departure") }.
    map(&:last).
    tap { |indices| p your_ticket.values_at(*indices).reduce(:*) }
end
