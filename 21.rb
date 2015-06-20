require './functions.rb'

total = 0

(1..10000).each do |i|
  sum = i.all_factors.inject(0){ |a, b| a + b } - i
  total += i if sum.all_factors.inject(0){ |a, b| a + b } - sum == i && sum != i
end

puts total
