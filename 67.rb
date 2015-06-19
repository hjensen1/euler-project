
a1 = nil

File.open('input_67.txt') do |file|
	a1 = file.readlines.inject(""){|a, b| a + b}.split(" ").map{|s| s.to_i}
end

a = []
sums = []
n = 1
i = 0
while i < a1.length
	a2 = []
	sum2 = []
	n.times do 
		a2 << a1[i]
		sum2 << 0
		i += 1
	end
	a << a2
	sums << sum2
	n += 1
end

sums[0][0] = a[0][0]
(1...a.length).each do |i|
	row = a[i]
	(0...row.length).each do |j|
		left = j == 0 ? 0 : sums[i - 1][j - 1]
		right = j == row.length - 1 ? 0 : sums[i - 1][j]
		sums[i][j] = a[i][j] + [left, right].max
	end
end

puts sums.last.max
