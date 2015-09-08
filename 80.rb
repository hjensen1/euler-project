require './functions.rb'

def sqrt(n, decimals)
  pairs = []
  digits = []
  while n > 0
    pairs.unshift(n % 100)
    n /= 100
  end
  remainder = 0
  x = y = p = r = i = 0
  while digits.size < decimals
    r = (r - y) * 100 + (pairs[i] ? pairs[i] : 0)
    if i == pairs.size
      break if r == 0
    end
    x = part(r, p)
    y = (p + x) * x
    digits << x
    i += 1
    p = 10 * p + 20 * x
  end
  digits
end

def part(target, p)
  if p < 100
    (0..9).each do |x|
      if (p + x) * x > target
        return x - 1
      end
    end
    return 9
  else
    x = target / p
    if (p + x) * x > target
      x -= 1
    end
    return x
  end
end

sum = 0
(1..100).each do |n|
  result = sqrt(n, 100)
  sum += result.sum if result.size == 100
end

puts sum

Timer.print
