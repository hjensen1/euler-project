require './functions.rb'

threes = []
(1..100000).each do |i|
  threes << (i * (i + 1) / 2)
end

fives = []
(1..100000).each do |i|
  fives << (i * (3 * i - 1) / 2)
end

sixes = []
(1..100000).each do |i|
  sixes << (i * (2 * i - 1))
end

result = 0
threes.each do |n|
  if (fives.binclude?(n) && sixes.binclude?(n) && n > 40755)
    result = n
    break
  end
end

puts result

Timer.print
