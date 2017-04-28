require './functions.rb'

def generate
  result = []
  t = 0
  500500.times do |k|
    t = (615949 * t + 797807) % (1 << 20)
    result << t - (1 << 19)
  end
  result
end

def to_triangle(array)
  y = x = 1
  result = []
  row = []
  array.each do |n|
    row << n
    x += 1
    if x > y
      x = 1
      y += 1
      result << row
      row = []
    end
  end
  result
end

def memoize_array(array)
  result = []
  sum = 0
  array.each do |x|
    result << (sum += x)
  end
  result
end

def solve(triangle)
  best = 0
  memoized = triangle.map { |row| memoize_array(row) }
  memoized.each_with_index do |row, y|
    puts "On row #{y + 1}" if (y + 1) % 100 == 0
    row.each_with_index do |top, x|
      w = 0
      sum = 0
      while y + w < triangle.size
        sum += memoized[y + w][x + w] - (x == 0 ? 0 : memoized[y + w][x - 1])
        best = sum if sum < best
        w += 1
      end
    end
  end
  best
end

@triangle = to_triangle(generate)
# @triangle = to_triangle([15, -41, -7, 20, -13, -5, -3, 8, 23, -26, 1, -4, -5, -18, 5, -16, 31, 2, 9, 28, 3])

puts solve(@triangle)

Timer.print
