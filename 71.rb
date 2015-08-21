require './functions.rb'

best = 0
max = 2.0 / 5
(2..1000000).each do |n|
  next if n % 7 == 0
  numerator = 3 * n / 7
  val = numerator.to_f / n
  if val > max
    max = val
    best = n
  end
end

puts best * 3 / 7
Timer.print
