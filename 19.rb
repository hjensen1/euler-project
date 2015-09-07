require './functions.rb'

sum = 0

(1901..2000).each do |y|
  (1..12).each do |m|
    sum += 1 if day_of_week("#{m}/1/#{y}") == "Sunday"
  end
end

puts sum

Timer.print
