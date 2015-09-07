require './functions.rb'

count = 0

(1..100).each do |x|
  prev = false
  (2..(x/2)).each do |y|
    if (x.c(y) > 1000000)
      prev = true
      count += (y == x / 2.0) ? 1 : 2
    end
  end
end

puts count

Timer.print
