

def repeats(n)
  result = '.'
  current = 10
  used = []
  while !used.include?(current) && current != 0
    used << current
    if current >= n
      result << (current / n).to_s
      current = (current % n) * 10
    else
      current *= 10
      result << "0"
    end
  end
  
  current == 0 ? 0 : used.size - used.index(current)
end

max = 0
max_value = 0
(1..999).each do |i|
  r = repeats(i)
  max, max_value = r, i if r > max
end

puts max
puts max_value