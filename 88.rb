require './functions.rb'

puts "This takes a few minutes..."
# Factors.set_factor_arithmetic(true)
@bests = Hash.new(1_000_000)

def iterate_factors(n, factors, function)
  if n == 1
    function.call(factors)
    return
  else
    n.enumerate_factors(2, n, true).each do |f|
      factors << f
      iterate_factors(n./(f, true), factors, function)
      factors.pop
    end
  end
end

@f = lambda do |factors|
  prod = factors.product
  sum = factors.sum
  count = prod - sum + factors.size
  if count <= 12000 && count >= 2
    @bests[count] = prod if prod < @bests[count]
  end
end

Factors.enumerate(4, 20000).each do |n|
  next if n.is_prime?
  iterate_factors(n, [], @f)
end


# puts @bests.inspect
puts @bests.values.uniq.sum

Timer.print
