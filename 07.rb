require './functions.rb'

# returns a list of the first n primes using seive of eratothenes
def prime_sieve2(limit)
  primes = []
  i = 1
  while (primes.size < limit) do
    i += 1
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

puts prime_sieve2(10001).last

Timer.print
