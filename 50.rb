require './functions.rb'

max = 0
max_count = 0
prime_list.each_with_index do |p, i|
  break if p > 100000
  sum = p
  count = 1
  best = p
  best_count = 1
  ((i + 1)..(i + 1000)).each do |j|
    p2 = prime_list[j]
    count += 1
    sum += p2
    if sum.is_prime?
      best = sum
      best_count = count
    end
    break if sum > 1000000
  end
  if best_count > max_count
    max = best
    max_count = best_count
  end
end

puts max_count
puts max
