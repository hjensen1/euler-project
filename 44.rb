require './functions.rb'

numbers = []
(1..5000).each do |i|
  numbers << i * (3 * i - 1) / 2
end

min = 1000000
n1 = 0
n2 = 0

(1..((numbers.size - 1) / 3)).each do |i|
  x = numbers[i * 3 - 1]
  (i..((numbers.size - 1) / 3)).each do |j|
    y = numbers[j * 3 - 1]
    sum = x + y
    next unless numbers.bsearch{ |a| a >= sum} == sum
    diff = x > y ? x - y : y - x
    next unless numbers.bsearch{ |a| a >= diff} == diff
    if diff < min
      min = diff
      n1 = x
      n2 = y
    end
  end
  break if min < 1000000
end

puts n1
puts n2
puts min
