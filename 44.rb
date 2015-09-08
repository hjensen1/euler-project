require './functions.rb'

numbers = []
parts = []
(1..5000).each do |i|
  numbers << i * (3 * i - 1) / 2
  parts << [i, i * (i - 1) / 2]
end

n1 = 0
n2 = 0

numbers.each_with_index do |x, i|
  prev = 0
  ((i + 1)...numbers.size).each do |j|
    y = numbers[j]
    break if x < y - prev && prev > 0
    sum = x + y
    check = false
    diff = y - x
    if numbers.binclude?(sum)
      if numbers.binclude?(diff)
        check = true
        n1 = x
        n2 = y
        break
      end
    end
    break if check
    prev = y
  end
end
puts n1
puts n2
puts n2 - n1

Timer.print
