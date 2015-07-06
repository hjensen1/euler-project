require './functions.rb'

Timer.start
primes = 0
total = 1
x = 1
side = 0

(1..50000).each do |i|
  4.times do
    x += (2 * i)
    primes += 1 if x.is_prime?
    total += 1
  end
  if primes * 10 < total
    side = 1 + 2 * i
    break
  end
end
Timer.print

puts side
