require './functions.rb'

abundants = []

(12..28123).each do |i|
  abundants << i if all_factors(i).inject(-i){ |a,b| a + b } > i
end

results = []
(1..28123).each do |i|
  stop = false
  abundants.each do |a|
    if abundants.bsearch{|x| x >= i - a} == i - a
      stop = true
      break
    end
    break if a > i
  end
  results << i unless stop
end

puts results.inject(0){ |a,b| a + b }
