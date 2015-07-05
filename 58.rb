require './functions.rb'

t1 = Time.now
Primes.set_pages(1)
prime_list
t2 = Time.now
primes = 0
total = 1
x = 1
side = 0

(1..50000).each do |i|
  stop = false
  4.times do
    x += (2 * i)
    is_prime = x.is_prime?
    stop = true if is_prime == nil
    primes += 1 if is_prime
    total += 1
  end
  if stop
    puts "Ratio: #{primes}/#{total} = #{1.0 * primes / total}"
    break
  end
  puts "    #{primes}/#{total}"
  if primes * 10 < total
    side = 1 + 2 * i
    break
  end
end
t3 = Time.now

puts "Took #{t2.to_f - t1.to_f} seconds to import primes."
puts "Entire process took #{t3.to_f - t1.to_f} seconds."
puts side
