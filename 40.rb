require './functions.rb'

def nth_digit(n)
  x = n - 1
  z = 0
  (1..10).each do |y|
    a = y * ((10 ** y) - 10 ** (y - 1))
    z = y
    break if x - a < 0
    x -= a
  end
  index = x / z
  digit = x % z
  num = 10 ** (z-1) + index
  return num.digits[digit]
end

array = [nth_digit(1), nth_digit(10), nth_digit(100), nth_digit(1000),
        nth_digit(10000), nth_digit(100000), nth_digit(1000000)]
puts array.to_s
puts array.product
