require './pell.rb'

count = 0
results = pell_multiples(3) { |x, y| 4 * x * x < 1_000_000_000 }
solutions = []
results.each do |s|
  x, y = s
  a = [2 * x * x - 2 * y * y, x * x + y * y, x * x + y * y].sort
  solutions << a unless solutions.include?(a)
  n = 2 * y + x
  m = y
  p = 2 * (n * n + m * m) + 4 * m * n
  if p < 1_000_000_000
    a = [4 * m * n, n * n + m * m, n * n + m * m].sort
    solutions << a unless solutions.include?(a)
  end
  n = 2 * y - x
  if n > 0
    m = y
    p = 2 * (n * n + m * m) + 4 * m * n
    if p < 1_000_000_000
      a = [4 * m * n, n * n + m * m, n * n + m * m].sort
      solutions << a unless solutions.include?(a)
    end
  end
end

sum = 0
solutions.each do |array|
  sum += array.sum unless array.sum > 1_000_000_000
end

puts solutions.inspect
puts sum

Timer.print

# 4*m*n + 1 == m2 + n2
# m^2 - 4mn + (n^2 - 1) = 0
# m = (2n +- sqrt(3n^2 + 1))
# 3n^2 + 1 = x^2
 
# m2 - 3*n2 == 1
