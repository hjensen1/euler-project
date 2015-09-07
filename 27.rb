require './functions.rb'

def count_primes(a, b)
  (0..10000).each do |n|
    p = n * n + a * n + b
    return n unless prime_list.bsearch{|x| x >= p} == p
  end
  return nil
end

max = 0
best_a = 0
best_b = 0
smallest_prime_factor = 41

# b must have smallest prime factor > 80 in order to be better than those presented in the problem
(41..1000).each do |b|
  skip = false
  prime_list.each do |p|
    break if p >= smallest_prime_factor
    if b % p == 0
      skip = true
      break
    end
  end
  next if skip
  (0..1000).each do |a|
    x = count_primes(a, b)
    max, best_a, best_b = x, a, b if x > max
    x = count_primes(-a, b)
    max, best_a, best_b = x, -a, b if x > max
    x = count_primes(a, -b)
    max, best_a, best_b = x, a, -b if x > max
    x = count_primes(-a, -b)
    max, best_a, best_b = x, -a, -b if x > max
  end
end

puts max
puts best_a
puts best_b
puts best_a * best_b

Timer.print
