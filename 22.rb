require './functions.rb'
a = read_input('input_22.txt')
a.sort!

sum = 0
a.each_with_index do |s, i|
  score = 0
  base = 'A'.getbyte(0) - 1
  (0...s.length).each do |j|
    score += s.getbyte(j) - base
  end
  sum += score * (i + 1)
end

puts sum
