require './functions.rb'

place = 1
nums = (0..9).to_a
result = []

while place < 1000000
  nums.each do |x|
    f = factorial(nums.size - 1)
    if (place + f <= 1000000)
      place += f
    else
      nums.delete(x)
      result << x
      break
    end
  end
end
result += nums

puts result.join("")