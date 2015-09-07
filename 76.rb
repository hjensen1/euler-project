require './functions.rb'

# @counts = {}
# 
# def get_count(x, maximum = x)
#   maximum = x if maximum > x
#   if x <= 0
#     return maximum == 0 ? 1 : 0
#   elsif maximum == 1
#     return 1
#   elsif maximum == 2
#     return x / 2 + 1
#   elsif @counts[[x, maximum]]
#     return @counts[[x, maximum]]
#   else
#     count = 0
#     (1..maximum).each do |i|
#       count += get_count(x - i, i)
#     end
#     @counts[[x, maximum]] = count
#     return count
#   end
# end
# 
# puts get_count(100, 99)
puts partitions(100) - 1

Timer.print
