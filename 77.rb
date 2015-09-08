require './functions.rb'

answer = nil
(1..100).each do |n|
  result = coin_partitions(n, n - 1, prime_list)
  answer = n if !answer && result > 5000
end
puts answer

Timer.print
