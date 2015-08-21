require './functions.rb'

product = 1
prime_list.each do |p|
  product *= p
  if product > 1000000
    product /= p
    break
  end
end

puts product
Timer.print
