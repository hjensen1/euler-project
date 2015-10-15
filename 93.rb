require './functions.rb'

class Fixnum
  def divide(other)
    self / other.to_f
  end
end

class Float
  def divide(other)
    self / other.to_f
  end
end

@methods = [:+, :-, :*, :divide]

def solutions(nums, methods, hash)
  a, b, c, d = nums
  m1, m2, m3 = methods
  add hash, (a.send(m1, b.send(m2, c.send(m3, d))) rescue nil)
  add hash, (a.send(m1, b.send(m2, c).send(m3, d)) rescue nil)
  add hash, (a.send(m1, b).send(m2, c.send(m3, d)) rescue nil)
  add hash, (a.send(m1, b).send(m2, c).send(m3, d) rescue nil)
  add hash, (a.send(m1, b.send(m2, c)).send(m3, d) rescue nil)
end

def add(hash, n)
  hash[n.to_i] = 1 if n && n > 0 && n < 1000000 && n.to_i == n
end

digits = (0..9).to_a
best = 0
best_list = []
iterate_combinations(digits, 4) do |digits|
  hash = {}
  iterate_permutations(digits) do |nums|
    iterate_all(@methods, 3) do |methods|
      solutions(nums, methods, hash)
    end
  end
  i = 1
  while hash[i]
    i += 1
  end
  i -= 1
  if i > best
    best = i
    best_list = digits.dup
  end
end

puts best
puts best_list.join("")

Timer.print
