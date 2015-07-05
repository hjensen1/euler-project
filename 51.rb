require './functions.rb'

result = 0

prime_list.each do |p|
  digits = p.digits
  combos = 2 ^ (digits.size)
  indices = Hash.new{|h, k| h[k] = []}
  digits.each_with_index do |d, i|
    indices[d] << i
  end
  indices.each_pair do |d, a|
    start = a.include?(0) ? 1 : 0
    count = 0
    ds = digits.dup
    (start..9).each do |x|
      a.each do |i|
        ds[i] = x
      end
      count += 1 if combine_digits(ds).is_prime?
    end
    if count == 8
      result = p
      break
    end
  end
  break if result > 0
end

puts result
