require './functions.rb'


list = []
sum = 0
(10..360000).each do |i|
  s = 0
  i.digits.each do |d|
    s += d ^ 5
    break if s > i
  end
  sum += s if s == i
  list << s if s == i
end

puts list
puts sum
