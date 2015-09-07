require './functions.rb'

sqrt = Math.sqrt(0.5)
(2..100000).each do |b|
  t = (b * sqrt).to_i + 1
  if b * (b - 1) == 2 * t * (t - 1)
    puts "#{t}/#{b} * #{t - 1}/#{b - 1} = 1/2"
  end
end


Timer.print


# x(x-1)/y(y-1) = 1/2
# 2x(x-1) = y(y-1)
#
#
#
#