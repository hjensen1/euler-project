require './functions.rb'

list = []

(1...10000).each do |i|
  x = i
  49.times do
    ds = x.digits
    x = combine_digits(ds) + combine_digits(ds.reverse)
    if (is_palindrome(x))
      list << i
      break
    end
  end
end

puts 9999 - list.size
