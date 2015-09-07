require './functions.rb'

@counts = {}

def get_count(x, maximum = x)
  maximum = x if maximum > x
  if x <= 0
    return maximum == 0 ? 1 : 0
  elsif maximum < 2 || x < 2
    return 0
  elsif maximum == 2
    return x % 2 == 0 ? 1 : 0
  elsif @counts[[x, maximum]]
    return @counts[[x, maximum]]
  else
    count = 0
    prime_list.each do |p|
      break if p > maximum
      count += get_count(x - p, p)
    end
    @counts[[x, maximum]] = count
    return count
  end
end

answer = nil
(1..100).each do |n|
  result = get_count(n, n - 1)
  puts result
  answer = n if !answer && result > 5000
end
puts answer

Timer.print
