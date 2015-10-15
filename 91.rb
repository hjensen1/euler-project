require './functions.rb'

def count(x, y)
  factored = Array.new([x, y].max + 1) { |i| i }.map { |i| Factors.new(i) }
  count = x * y * 3
  (1..x).each do |i|
    (1..i).each do |j|
      j2, i2 = factored[i].cancel_factors(factored[j])
      limit1 = [(y - j) / j2, i / i2].min
      limit2 = j == i ? 0 : [j / j2, (x - i) / i2].min
      count += (limit1 + limit2) * 2
    end
  end
  count
end

puts count(50, 50)

Timer.print
