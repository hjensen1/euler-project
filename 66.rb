require './functions.rb'

max = 0
best = 0

def coefficients(n, s, b, c)
  b1 = (n - c * c) / b
  a1 = (s + c) / b1
  c1 = (a1 * b1) - c
  return a1, b1, c1
end

def continued(n)
  a = s = c = Math.sqrt(n).to_i
  return [] if s * s == n
  b = 1
  results = [[a,b,c]]
  r = -1
  loop do
    a, b, c = coefficients(n, s, b, c)
    results << [a, b, c]
    break if results.size == r
    if r < 0 && results.index(results.last) != results.size - 1
      r = results.size - 2
      if r % 2 == 0
        results.pop
        results.pop
        break
      else
        r = 2 * r
        if results.size > r
          results.pop
          break
        end
      end
    end
  end
  results
end

def solve(n)
  return [0, 0] if Math.sqrt(n).to_i ** 2 == n
  sequence = continued(n).reverse
  
  bottom = sequence.shift[0]
  top = 1
  sequence.each do |x|
    x = x[0]
    top += x * bottom
    top, bottom = bottom, top
  end

  return cancel_factors(bottom, top)
end

(6..1000).each do |d|
  x, y = solve(d)
  puts "#{x} ^ 2 - #{d} * #{y} ^ 2 = 1"
  if x > max
    max = x
    best = d
  end
end

# (6..1000).each do |d|
#   start = Time.now
#   next if Math.sqrt(d).round ** 2 == d
#   m = 1
#   factors = (d * 2).all_factors
#   loop do
#     check = false
#     factors.each do |f|
#       x = f * m * m
#       y = x * (x + 2)
#       next unless y % d == 0
#       y /= d
#       s = Math.sqrt(y).round
#       if s > 0 && s * s == y
#         x1 = solve(d)[0]
#         if x + 1 != x1
#           puts "Error: d = #{d}, solve(d) = #{x1}, x = #{x + 1}"
#         end
#         puts "#{x + 1} ^ 2 - #{d} * #{s} ^ 2 = 1"
#         check = true
#       end
#     end
#     break if check
#
#     #puts m
#     break if Time.now.to_f - start.to_f > 2
#     m += 1
#   end
# end

puts max
puts best
Timer.print
