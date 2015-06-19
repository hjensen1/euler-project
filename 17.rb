require './functions.rb'

count = 0

(1..1000).each do |i|
	count += number_to_words(i).gsub(/[ -]/, "").length
end

puts count