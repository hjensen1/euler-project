require './functions.rb'

count = 0

(1..1000).each do |i|
  count += i.to_words.gsub(/[ -]/, "").length
end

puts count

Timer.print
