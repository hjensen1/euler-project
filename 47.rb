require './functions.rb'

count = 0
first = 0
(1..1000000).each do |n|
  if !n.is_prime? && n.factorize.size == 4
    first = n if count == 0
    count += 1
    break if count == 4
  else
    count = 0
    first = 0
  end
end

puts first

Timer.print
