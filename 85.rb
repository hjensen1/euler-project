require './functions.rb'

def rectangles(x, y)
  x * (x + 1) * y * (y + 1) / 4
end

z = 0
closest = 1000000
result = 0
(1..2000).each do |x|
  (1..x).each do |y|
    count = rectangles(x, y)
    diff = count < 2000000 ? 2000000 - count : count - 2000000
    if diff < closest
      result = x * y
      closest = diff
      z = count
    end
  end
end

puts z
puts result

Timer.print
