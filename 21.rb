require './functions.rb'

total = 0

(1..10000).each do |i|
  sum = all_factors(i).inject(0){ |a, b| a + b } - i
  total += i if all_factors(sum).inject(0){ |a, b| a + b } - sum == i && sum != i
end

puts total
