
a = nil
File.open('input_22.txt') do |file|
	a = file.readlines.first.split(',').map{|s| s.gsub('"', '')}
end

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
