require './functions.rb'

count = 0
(5..12000).each do |n|
  factors = n.factorize.keys
  min = n / 3 + 1
  max = n / 2
  (min..max).each do |x|
    skip = false
    factors.each do |f|
      if x % f == 0
        skip = true
        break
      end
    end
    count += 1 unless skip
  end
end

puts count
Timer.print

