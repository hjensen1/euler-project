require './pell.rb'

max = 0
best = 0

(6..1000).each do |d|
  x, y = solve_pell(d)
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
