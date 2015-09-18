require './functions.rb'

totals = [21, 120]
blues = [15, 85]
ratio = 120.0 / 21
sqrt = Math.sqrt(0.5)
misses = 0
while totals.last < 10 ** 12
  t = (totals.last * ratio).to_i
  loop do
    b = (t * sqrt).to_i + 1
    if 2 * b * (b - 1) == t * (t - 1)
      puts "2*#{b}*#{b-1} == #{t}*#{t-1} : #{t.to_f/totals.last}"
      ratio = t.to_f / totals.last
      totals << t
      blues << b
      break
    else
      misses += 1
      t += 1
    end
  end
end

puts blues.last

Timer.print
