require './functions.rb'

min = 2
best = 0
filter_index = 30
numbers = []
(2..10000000).each do |x|
  skip = false
  prime_list.each_with_index do |p, i|
    break if i > filter_index
    if x % p == 0
      skip = true
      break
    end
  end
  numbers << x unless skip || x.is_prime?
end
print "Filtered to #{numbers.size} numbers. "
Timer.print
numbers.each do |x|
  skip = false
  (31..filter_index).each do |i|
    if x % prime_list[i] == 0
      skip = true
      break
    end
  end
  next if skip
  totient = x.totient
  if totient.digits.sort == x.digits.sort
    puts "#{x}, #{totient}, #{filter_index}"
    if x.to_f / totient < min
      min = x.to_f / totient
      best = x
      loop do
        p = prime_list[filter_index]
        break if (p.to_f / (p - 1)) < min
        filter_index += 1
      end
    end
  end
end

puts min
puts best
Timer.print
