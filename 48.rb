
big = 10000000000

sum = 0
(1..1000).each do |n|
  next if n % 10 == 0
  prod = 1
  n.times do
    prod *= n
    prod = prod % big if prod > big
  end
  sum += prod
end

puts sum % big
