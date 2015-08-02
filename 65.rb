require './functions.rb'

sequence = []
(1..34).each do |x|
  sequence << 1 << 1 << (2 * x)
end
sequence = sequence.first(100)
sequence[0] = 2

sequence.reverse!

bottom = sequence.shift
top = 1
sequence.each do |x|
  top += x * bottom
  top, bottom = bottom, top
end

top, bottom = cancel_factors(top, bottom)
puts bottom.digits.sum
Timer.print
