#!/usr/bin/env ruby

require_relative "./advent21.1"

def foods_without_inert_ingredients
  foods.map do |ingredients, allergens|
    [ingredients - inert_ingredients, allergens]
  end
end

def allergenic_ingredients
  ingredients - inert_ingredients
end

def ingredient_present_in_all_foods_with_allergen?(ingredient, allergen)
  foods_without_inert_ingredients.
    select { |_i, a| a.include?(allergen) }.
    all? { |i, _a| i.include?(ingredient) }
end

def allergens_by_ingredient
  allergens.each_with_object({}) do |allergen, acc|
    acc[allergen] = allergenic_ingredients.select do |ingredient|
      ingredient_present_in_all_foods_with_allergen?(ingredient, allergen)
    end
  end.sort_by { |_k, v| v.count }
end

def elimination
  coll = allergens_by_ingredient
  res = {}
  coll.count.times do
    e = coll.shift
    res[e.first] = e.last.first
    coll.each { |_a, i| i.delete(e.last.first) }
  end
  res
end

if __FILE__ == $0
  puts elimination.sort_by { |k, _v| k }.map { |_k, v| v }.join(",")
end
