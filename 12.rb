require './functions.rb'

sum = 0
n = 0
num_factors = 0

while num_factors < 500
  n += 1
  sum += n
  num_factors = sum.factorize.values.inject(1){ |x, count| x * (count + 1)}
end

puts sum

Timer.print
