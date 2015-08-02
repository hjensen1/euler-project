require './functions.rb'

sqrt = Math.sqrt(0.5)
prime_list.each do |p|
  next if p < 400000
  puts p
  n = 1000000000000 / p + 1
  t = n * p
  while (t < 1100000000000)
    b = (t * sqrt).to_i + 1
    if b * (b - 1) * 2 == t * (t - 1)
      puts "#{b}/#{t}*#{b - 1}/#{t - 1} = 1/2"
    end
    n += 1
    t = n * p
  end
end


Timer.print
