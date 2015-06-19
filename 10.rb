require './functions.rb'

puts prime_sieve(2000000).inject(0) { |a, x| a + x}