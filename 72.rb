require './functions.rb'

def totient(n, factors)
  result = n
  factors.each do |f|
    result = result * (f - 1) / f
  end
  result
end

sum = 0
Factors.enumerate(2, 1000000).each do |f|
  sum += totient(f, f.factors.keys)
end

puts sum
Timer.print
