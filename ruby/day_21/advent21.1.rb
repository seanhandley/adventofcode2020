#!/usr/bin/env ruby

def foods
  @foods ||= STDIN.readlines.map(&method(:parse))
end

def parse(line)
  ingredients, allergens = line.gsub("(", "").gsub(")", "").split(" contains ")
  [ingredients.split.map(&:strip), allergens.split(", ").map(&:strip)]
end

def ingredients
  foods.flat_map(&:first).uniq
end

def allergens
  foods.flat_map(&:last).uniq
end

def inert_ingredients
  @inert_ingredients ||= (ingredients.reject do |ingredient|
    allergens.any? do |allergen|
      foods.all? do |food|
        if food.last.include?(allergen)
          food.first.include?(ingredient)
        else
          true
        end
      end
    end
  end)
end

def inert_ingredients_count
  inert_ingredients.sum do |ingredient|
    foods.count do |ingredients, _allergens|
      ingredients.include?(ingredient)
    end
  end
end

if __FILE__ == $0
  p inert_ingredients_count
end
