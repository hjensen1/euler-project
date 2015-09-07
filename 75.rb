require './functions.rb'

hash = Hash.new{ |h, k| h[k] = [] }
results = []
limit = Math.sqrt(2) - 1
Factors.enumerate(2, 750000).each do |a|
  a2 = a ** 2
  #a2.factors[2] = a2.factors[2] / 2 if a2.factors[2] > 0
  a2.enumerate_factors(1, a * limit).each do |n|
    next if n % 2 != 0 && a % 2 == 0
    b = ((a2 / n) - n) / 2
    c = b + n
    next unless a ** 2 + b * b == c * c
    results << [a.to_i, b, c]
    hash[a + b + c] << [a.to_i, b, c]
  end
end

results.each do |triple|
  a, b, c = triple
  unless a * a + b * b == c * c
    puts "#{a} ^ 2 + #{b} ^ 2 != #{c} ^ 2"
  end
end

count = 0
(1..1500000).each do |l|
  count += 1 if hash[l].size == 1
end

puts results.size
puts hash.size
puts count
Timer.print
