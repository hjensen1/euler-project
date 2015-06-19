n = 1
m = 2
total = 0
while (m <= 4000000) do
	total += m if m % 2 == 0
	temp = m
	m = n + m
	n = temp
end
puts total