#!/usr/bin/env ruby

require_relative "./advent16.1"

def valid_tickets
  nearby_tickets.reject do |ticket|
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
  orderings = all_valid_positions
  orderings.each_with_index.each_with_object({}) do |((field, positions), i), result|
    num = positions.first
    result[field] = num
    orderings.each { |f, p| p.delete(num) }
  end
end

if __FILE__ == $0
  valid_ordering.
    sort_by(&:last).
    select { |field, _position| field.start_with?("departure") }.
    map(&:last).
    tap { |indices| p your_ticket.values_at(*indices).reduce(:*) }
end
