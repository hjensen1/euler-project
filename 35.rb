require './functions.rb'

list = []

prime_list.each do |p|
  break if p > 1000000
  digits = p.digits
  start = digits.dup
  digits.unshift(digits.pop)
  check = true
  while (digits != start)
    a = combine_digits(digits)
    if (prime_list.bsearch{|x| x >= a} != a)
      check = false
      break
    end
    digits.unshift(digits.pop)
  end
  list << p if check
end

puts list.size