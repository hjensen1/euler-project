
a = 0
b = 0
(1..100).each do |i|
  a += i * i
  b += i
end
b = b * b
puts b - a