
max_value = 0
max_count = 0
list = []

(12..1000).each do |n|
  count = 0
  (1..(n/4)).each do |a|
    (a..(n/2)).each do |b|
      c = n - a - b
      if a * a + b * b == c * c
        count += 1
        list << [a,b,c]
      end
    end
  end
  if count > max_count
    max_count = count
    max_value = n
  end
end

puts list.to_s
puts max_count
puts max_value