require './functions.rb'

max = 0
best = 0
failed = []
(3..1000).each do |d|
  start = Time.now
  next if Math.sqrt(d).round ** 2 == d
  m = 1
  factors = (d * 2).all_factors
  loop do
    check = false
    factors.each do |f|
      x = f * m * m
      y = (x - 0) * (x + 2)
      next unless y % d == 0
      y /= d
      s = Math.sqrt(y).round
      if s > 0 && s * s == y
        if x + 1 > max
          max = x + 1
          best = d
        end
        puts "#{x + 1} * #{x + 1} - #{d} * #{s} * #{s} = 1"
        check = true
      end
    end
    break if check
    
    #puts m
    m += 1
    if Time.now.to_f - start.to_f > 5
      failed << d
      break
    end
  end
end

puts failed.inspect
puts best
Timer.print
