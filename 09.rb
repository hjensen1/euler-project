
(1..332).each do |a|
	(a..499).each do |b|
		c = 1000 - a - b
		if (a * a + b * b == c * c)
			puts [a, b, c]
			puts a * b * c
			break
		end
	end
end