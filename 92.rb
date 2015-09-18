require './functions.rb'

array = Array.new(568)
array[1] = 1
array[89] = 89
count = 0
(2...10_000_000).each do |x|
  steps = []
  steps << x if x < 568
  while !array[x]
    x = x.digits.map{ |n| n * n }.sum
    steps << x
  end
  steps.each do |y|
    array[y] = array[x]
  end
  count += 1 if array[x] == 89
end

puts count

Timer.print
