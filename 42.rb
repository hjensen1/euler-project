require './functions.rb'

def is_triangular(n)
  f = ((-1 + Math.sqrt(1 + 4 * 2 * n)) / 2).round
  return f * (f + 1) / 2 == n
end

a = read_input('input_42.txt').first
base = 'A'.getbyte(0) - 1
count = 0

a.each do |s|
  score = 0
  (0...s.length).each do |j|
    score += s.getbyte(j) - base
  end
  count += 1 if is_triangular(score)
end

puts count

Timer.print
