require './functions.rb'

count = 0
first = 0
list = Factors.enumerate(647, 1000000).sort
list.each do |n|
  if n.factors.size == 4
    first = n if count == 0
    count += 1
    break if count == 4
  else
    count = 0
    first = 0
  end
end

puts first

Timer.print
