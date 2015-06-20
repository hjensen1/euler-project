require './functions.rb'


list = []
sum = 0
(10..360000).each do |i|
  s = 0
  digits_of(i).each do |d|
    s += power(d, 5)
    break if s > i
  end
  sum += s if s == i
  list << s if s == i
end

puts list
puts sum
