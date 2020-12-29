#!/usr/bin/env ruby

class Integer
  # This is the "Baby Step Giant Step" algorithm.
  # https://en.wikipedia.org/wiki/Baby-step_giant-step
  #
  # It is commonly used to calculate a discrete logarithm.
  #
  # The key exchange algorithm in this puzzle is Diffie-Hellman,
  # which uses the calculation:
  # 
  #   key = base ** exponent % modulo
  #
  # The discrete logarithm is the *inverse* of this i.e. we start with the
  # result from the above calculation, and we know the modulo, but the exponent
  # is unknown:
  #
  #   exponent = baby_step_giant_step(base, key, modulo)
  #
  # This algorithm finds the exponent orders of magnitude faster than brute-force.
  def discrete_logarithm(base, modulo)
    # Baby-step: Create the lookup table.
    n = Math.sqrt(modulo - 1).ceil
    lookup = n.times.each_with_object({}) do |i, acc|
      acc[base.pow(i, modulo)] = i
    end
    # Fermat's Little Theorem
    # https://en.wikipedia.org/wiki/Fermat%27s_little_theorem
    c = base.pow(n * (modulo - 2), modulo)
    # Giant-step: Search in the lookup table.
    n.times do |i|
      y = self * c.pow(i, modulo) % modulo
      return i * n + lookup[y] if lookup[y]
    end
    raise "No logarithm found"
  end
end

BASE = 7
MODULO = 2020_12_27

def input
  @input ||= STDIN.read.split.map(&:to_i)
end

def card_public_key
  input.first
end

def door_public_key
  input.last
end

def card_exponent
  @card_exponent ||= card_public_key.discrete_logarithm(BASE, MODULO)
end

def door_exponent
  @door_exponent ||= door_public_key.discrete_logarithm(BASE, MODULO)
end

def door_encryption_key
  door_public_key.pow(card_exponent, MODULO)
end

def card_encryption_key
  card_public_key.pow(door_exponent, MODULO)
end

def encryption_key
  door_encryption_key.tap do |result|
    unless card_encryption_key == result
      raise "Computed key is different for card and door"
    end
  end
end

p encryption_key
