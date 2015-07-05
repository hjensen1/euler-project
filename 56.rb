require './functions.rb'

max = 0

(1..100).each do |x|
  (1..100).each do |y|
    z = x ^ y
    sum = z.digits.sum
    max = sum if sum > max
  end
end

puts max
