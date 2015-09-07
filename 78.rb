require './functions.rb'

(1..1000000).each do |n|
  puts n if n % 10000 == 0
  count = partitions(n)
  if count % 1000000 == 0
    puts count
    puts n
    break
  end
end

Timer.print
