#!/usr/bin/env ruby

def input
  @input ||= STDIN.readlines
end

def dimensions
  3
end

def new_grid(default_cell_val, dimensions)
  Hash.new do |h, k|
    h[k] = dimensions == 1 ? default_cell_val : new_grid(default_cell_val, dimensions - 1)
  end
end

def directions(dimensions)
  [-1, 0, 1].repeated_permutation(dimensions).
             reject { |pos| pos == [0] * dimensions }
end

def neighbours(*args)
  directions(args.length).each_with_object([]) do |direction, collection|
    collection << args.zip(direction).map { |d| d.sum }
  end
end

def count_in_grid(grid, cell_val)
  return (grid == cell_val ? 1 : 0) unless grid.is_a?(Hash)

  grid.values.
       sum { |sub_grid| count_in_grid(sub_grid, cell_val) }
end

def neighbour_counts(grid)
  grid.each_with_object(new_grid(0, dimensions)) do |(element, indices), out|
    neighbour_counts_step([element], indices, dimensions, out)
  end
end

def neighbour_counts_step(indices, element, count, out)
  if count == 1
    if element == "#"
      neighbours(*indices).each do |neighbour_indices|
        *tail, head = neighbour_indices
        out.dig(*tail).
            store(head, out.dig(*neighbour_indices) + 1)
      end
    end
  else
    element.each { |x, y| neighbour_counts_step(indices + [x], y, count - 1, out) }
  end
end

def next_value(current_value, cell_neighbour_count)
  if current_value == "#"
    [2, 3].include?(cell_neighbour_count) ? "#" : "."
  else
    cell_neighbour_count == 3 ? "#" : "."
  end
end

def grid_from_neighbour_counts(grid, counts)
  counts.each_with_object(new_grid(".", dimensions)) do |(element, indices), out|
    grid_from_neighbour_counts_step([element], indices, dimensions, out, grid)
  end
end

def grid_from_neighbour_counts_step(indices, element, count, out, grid)
  if count == 1
    *tail, head = indices
    out.dig(*tail).store(head, next_value(grid.dig(*indices), element))
  else
    element.each { |x, y| grid_from_neighbour_counts_step(indices + [x], y, count - 1, out, grid)}
  end
end

def boot_cycle(grid, count = 6)
  return grid if count == 0

  boot_cycle(
    grid_from_neighbour_counts(
      grid, neighbour_counts(grid)
    ),
    count - 1
  )
end

def initial_grid
  new_grid(".", dimensions).tap do |grid|
    indices = Array.new(dimensions - 2) { 0 }

    input.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        *tail, head = indices.dup + [y, x]
        grid.dig(*tail).store(head, char)
      end
    end
  end
end

def count_active
  count_in_grid(boot_cycle(initial_grid), "#")
end

if __FILE__ == $0
  p count_active
end
