#!/usr/bin/env ruby

def input
  @input ||= STDIN.read.split("\n\n")
end

def rules
  @rules ||= input[0].split("\n").each_with_object({}) do |line, obj|
    matches = /(.+): (\d+)\-(\d+) or (\d+)\-(\d+)/.match(line)
    obj[matches[1]] = [
      matches[2].to_i..matches[3].to_i,
      matches[4].to_i..matches[5].to_i
    ]
  end
end

def your_ticket
  @your_ticket ||= input[1].
    split("\n").
    last.
    split(",").
    map(&:to_i)
end

def nearby_tickets
  @nearby_tickets ||= input[2].
    split("\n")[1..].
    map { |line| line.split(",").map(&:to_i) }
end

def invalid_for_all_fields?(val)
  rules.all? do |field, ranges|
    ranges.none? { |range| range.cover?(val) }
  end
end

def error_rate
  nearby_tickets.flat_map do |ticket|
    ticket.select(&method(:invalid_for_all_fields?))
  end.sum
end

if __FILE__ == $0
  p error_rate
end
