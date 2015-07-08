
prod = 1

1000.times do
  prod *= 2
end

sum = 0
while prod > 0
  sum += prod % 10
  prod /= 10
end

puts sum