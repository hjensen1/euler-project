require './functions.rb'

squares = []
cubes = []
fours = []
prime_list.each do |p|
  n = p * p
  squares << n if n < 50000000
  n *= p
  cubes << n if n < 50000000
  n *= p
  fours << n if n < 50000000
end

numbers = {}

squares.each do |a|
  cubes.each do |b|
    break if a + b > 50000000
    fours.each do |c|
      sum = a + b + c
      if sum < 50000000
        numbers[sum] = 1
      else
        break
      end
    end
  end
end

puts numbers.size

Timer.print
