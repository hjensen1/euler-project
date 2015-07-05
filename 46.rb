require './functions.rb'

squares = []
(1..750).each do |i|
  squares << (i * i * 2)
end

result = 0

(4..1000000).each do |n|
  next if n.is_prime? || n % 2 == 0
  check = true
  squares.each do |s|
    if ((n - s).is_prime?)
      check = false
      break
    end
    break if s > n
  end
  if (check)
    result = n
    break
  end
end

puts result
