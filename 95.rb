require './functions.rb'

array = Array.new(1_000_001, 1)
(2..500_000).each do |i|
  x = i + i
  while x < 1_000_000
    array[x] += i
    x += i
  end
end

lengths = {}
array.each do |n|
  if lengths[array[n]]
    lengths[n] = 0
    next
  end
  list = [n]
  loop do
    n = array[n]
    if !n
      list.each do |x|
        lengths[x] = 0
      end
      break
    end
    if list.include?(n)
      index = list.index(n)
      slice = list.slice(index, list.size)
      slice.each do |x|
        lengths[x] = slice.size
      end
      list.first(index).each do |x|
        lengths[x] = 0
      end
      break
    end
    list << n
  end
end

puts best = lengths.values.max
puts lengths.select { |k, v| v == best }.keys.min

Timer.print
