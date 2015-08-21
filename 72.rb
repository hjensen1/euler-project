require './functions.rb'

def totient(n, factors)
  result = n
  factors.each do |f|
    result = result * (f - 1) / f
  end
  result
end

sum = 0
factors = Hash.new(0)
n = 1
indices = []
i = 0
loop do
  p = prime_list[i]
  break if p > 1000000
  if n * p <= 1000000
    n *= p
    factors[p] += 1
    indices << i
    sum += totient(n, factors.keys)
  else
    p = prime_list[indices.last]
    n /= p
    if factors[p] == 1
      factors.delete(p)
    else
      factors[p] -= 1
    end
    i = indices.pop + 1
  end
end

puts sum
Timer.print
