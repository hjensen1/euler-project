require './functions.rb'

digits = [0,1,2,3,4,5,6,7,8,9]
list = []

(1..(1000/17)).each do |x|
  ds1 = (17 * x).digits
  ds1.unshift(0) if ds1.size < 3
  (2..(1000/7)).each do |y|
    ds2 = (7 * y).digits
    ds2.unshift(0) if ds2.size < 3
    next if (ds1 + ds2).uniq.size < 6
    (6..(499)).each do |z|
      ds3 = (2 * z).digits
      ds3.unshift(0) if ds3.uniq.size < 3
      next if (ds1 + ds2 + ds3).uniq.size < 9
      array = ds3 + ds2 + ds1
      first = (digits - array).first
      next if first == 0
      next if combine_digits(array[1,3]) % 3 != 0
      next if combine_digits(array[2,3]) % 5 != 0
      next if combine_digits(array[4,3]) % 11 != 0
      next if combine_digits(array[5,3]) % 13 != 0
      n = combine_digits(array)
      n += 1000000000 * (digits - array).first
      list << n
    end
  end
end

puts list.to_s
puts list.sum
