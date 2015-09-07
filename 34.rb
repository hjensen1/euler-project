require './functions.rb'

factorials = []

(0..9).each do |i|
  factorials << i.factorial
end

list = []

(10..3000000).each do |i|
  digits = i.digits
  sum = 0
  digits.each do |d|
    sum += factorials[d]
  end
  list << i if i == sum
end

puts list
puts list.sum

Timer.print
