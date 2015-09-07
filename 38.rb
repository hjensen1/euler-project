require './functions.rb'

match = [1,2,3,4,5,6,7,8,9]
hash = {}
(1..9999).each do |n|
  digits = []
  (1..9).each do |i|
    break if digits.size >= 9
    digits += (i * n).digits
  end
  hash[n] = combine_digits(digits) if digits.size == 9 && digits.sort == match
end

puts hash
puts hash.values.sort.last

Timer.print
