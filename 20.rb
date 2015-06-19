
prod = 1

(2..100).each do |i|
  prod *= i
end

string = "#{prod}"
sum = 0
(0...string.length).each do |i|
  sum += string[i].to_i
end

puts sum
