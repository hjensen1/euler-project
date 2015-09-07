require './functions.rb'

# returns a list of all primes up to limit using seive of eratothenes
def prime_sieve(limit)
  primes = []
  (2..limit).each do |i|
    composite = false
    primes.each do |p|
      if i % p == 0
        composite = true
        break
      end
    end
    next if composite
    primes << i
  end
  return primes
end

puts prime_sieve(2000000).sum
Timer.print
