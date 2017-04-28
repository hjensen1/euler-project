require './functions.rb'

def side(x1, y1, x2, y2, xp, yp)
  if x1 == x2
    x1 <=> xp
  else
    m = (y2 - y1) / (x2 - x1)
    b = y2 - (x2 * m)
    ((m * xp + b) - yp).abs < 0.0001 ? 0 : (m * xp + b) <=> yp
  end
end

def inside?(e)
  pairs = [[0, 2, 4], [2, 4, 0], [4, 0, 2]]
  pairs.each do |pair|
    return false unless side(e[pair[0]], e[pair[0] + 1], e[pair[1]], e[pair[1] + 1], 0, 0) ==
      side(e[pair[0]], e[pair[0] + 1], e[pair[1]], e[pair[1] + 1], e[pair[2]], e[pair[2] + 1]) ||
      side(e[pair[0]], e[pair[0] + 1], e[pair[1]], e[pair[1] + 1], 0, 0) == 0
  end
  true
end

count = 0
examples = read_input("./input_102.txt").map { |example| example.map(&:to_i) }
examples.each do |e|
  count += 1 if inside?(e)
end

puts count

Timer.print
