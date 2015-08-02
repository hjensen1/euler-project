require './functions.rb'

list = []
(1..9).each do |x|
  (1..100).each do |n|
    y = x ** n
    top = 10 ** n
    bottom = 10 ** (n - 1)
    next if y < bottom
    break if y >= top
    list << y
  end
end

puts list.size
