require './functions.rb'

list = []
filter = [2,3,5,7]

prime_list.each do |p|
  dp = p.digits
  next if !filter.include?(dp.first) || !filter.include?(dp.last)
  check = true
  (1..dp.size).each do |i|
    a1 = combine_digits(dp[i,dp.length])
    a2 = combine_digits(dp[0, dp.length - i])
    if (!a1.is_prime? || !a2.is_prime?) && (a1 > 0 && a2 > 0)
      check = false
      break
    end
  end
  list << p if check && dp.size > 1
end

puts list.to_s
puts list.sum
