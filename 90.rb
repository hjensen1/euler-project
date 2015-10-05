require './functions.rb'

@squares = [[0,1], [0,4], [0,9], [1,6], [2,5], [3,6], [4,9], [6,4], [8,1]]
list = []
numbers = [0]
loop do
  if numbers.size == 6 && numbers.last < 10
    n1 = numbers.dup
    if n1.include?(6) && !n1.include?(9)
      n1 << 9
      n1.sort!
    elsif n1.include?(9) && !n1.include?(6)
      n1 << 6
      n1.sort!
    end
    list << n1
    numbers[5] += 1
  elsif 3 + numbers.size < numbers.last
    numbers.pop
    numbers[numbers.size - 1] += 1
    break if numbers.size == 1 && numbers[0] >= 5
  else
    numbers << numbers.last + 1
  end
end

def check(n1, n2)
  @squares.each do |s|
    unless (n1.include?(s[0]) && n2.include?(s[1])) || (n1.include?(s[1]) && n2.include?(s[0]))
      return false
    end
  end
  return true
end

count = 0
list.each_with_index do |n1, i|
  ((i+1)...list.size).each do |j|
    n2 = list[j]
    count += 1 if check(n1, n2)
  end
end

puts count

Timer.print
