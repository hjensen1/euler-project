require './functions.rb'

puts "takes a while..."
puts prime_sieve(2000000).inject(0) { |a, x| a + x}