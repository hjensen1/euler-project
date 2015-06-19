require './functions.rb'


max = 0
(100..999).each do |x|
	(100..999).each do |y|
		max = x * y if is_palindrome(x * y) && x * y > max
	end
end
puts max