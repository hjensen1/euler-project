
# solved by math: 1000 * log(10) / log((1 + sqrt(5)) / 2) = 4785
# this gives about the right answer since the ratio between consecutive terms approaches (1 + sqrt(2)) / 2
puts "guess: 4783"
puts "correct: 4782"

n1 = 1
n2 = 1
i = 2

limit = 10 ** 999

while (n2 < limit)
  i += 1
  temp = n1
  n1 = n2
  n2 = n1 + temp
end

puts n2
puts i