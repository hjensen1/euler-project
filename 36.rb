require './functions.rb'

list = []

(1..999).each do |i|
  ds = i.digits
  ds1 = ds + ds.reverse[1, ds.length ]
  ds2 = ds + ds.reverse
  c1 = combine_digits(ds1)
  c2 = combine_digits(ds2)
  list << c1 if is_palindrome(c1.digits(2))
  list << c2 if is_palindrome(c2.digits(2))
end

puts "#{list}"
puts list.sum