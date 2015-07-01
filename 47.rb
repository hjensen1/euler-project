require './functions.rb'

count = 0
first = 0
(1..100000).each do |n|
  next if n.is_prime
end

puts first
