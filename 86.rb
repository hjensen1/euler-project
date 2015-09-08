require './functions.rb'

triples = []
numbers = Factors.enumerate(1, 500).sort
numbers.each_with_index do |n, i|
  (0...i).each do |j|
    m = numbers[j]
    if (n % 2 == 0 || m % 2 == 0) && (n.factors.keys - m.factors.keys).size == n.factors.size
      a = n * n - m * m
      b = 2 * n * m
      c = n * n + m * m
      triples << [a, b, c]
    end
  end
end

triples.sort{ |a, b| a.sum - b.sum }
@triples = triples

def count_solutions(m)
  count = 0
  @triples.each do |t|
    a = t[0, 2].max
    break if a > m
    bc = t.min
    x = m / a
    count += bc * x * (x + 1) / 4 - (bc % 2) * (x + 1) / 4
    if bc * 2 > a
      a, bc = bc, a
      count += (2 * a - bc + 2) / 2
      while (a * 2 <= m)
        a += a
        bc += bc
        count += (2 * a - bc + 2) / 2
      end
    end
  end
  count
end

Timer.print
