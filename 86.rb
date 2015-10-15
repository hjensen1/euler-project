require './functions.rb'

triples = []
numbers = Factors.enumerate(1, 1000).sort
numbers.each_with_index do |n, i|
  (0...i).each do |j|
    m = numbers[j]
    if (n % 2 == 0 || m % 2 == 0) && (n.factors.keys - m.factors.keys).size == n.factors.size
      a = n * n - m * m
      b = 2 * n * m
      c = n * n + m * m
      triples << [a, b, c].sort
    end
  end
end

triples.sort{ |a, b| a.sum - b.sum }
@triples = triples

def count_solutions(m)
  count = 0
  @triples.each do |t|
    c1 = c = t[1]
    ab1 = ab = t[0]
    break if ab > 3 * m
    while ab <= m
      count += count2(ab, c) if c < 2 * ab
      count += count1(ab, m) if c <= m
      c += c1
      ab += ab1
    end
  end
  count
end

def count1(ab, m)
  b = [ab, m + 1].min - 1
  a = ab - b
  (b - a + 2) / 2
end

def count2(c, ab)
  b = [ab - 1, c].min
  a = ab - b
  (b - a + 2) / 2
end

puts count_solutions(100)
puts (1..10000).to_a.bsearch { |a| count_solutions(a) >= 1_000_000 }

Timer.print
