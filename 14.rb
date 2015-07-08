
hash = {}
max = 0
max_key = 0

(1..1000000).each do |i|
  steps = 0
  start = i
  while (i != 1)
    if hash[i]
      steps += hash[i]
      break
    end
    if i % 2 == 0
      i /= 2
    else
      i = 3 * i + 1
    end
    steps += 1
  end
  if steps > max
    max = steps
    max_key = start
  end
end

puts max_key
puts "#{max} steps"