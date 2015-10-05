require './functions.rb'

def coefficients(n, s, b, c)
  b1 = (n - c * c) / b
  a1 = (s + c) / b1
  c1 = (a1 * b1) - c
  return a1, b1, c1
end

def continued(n)
  a = s = c = Math.sqrt(n).to_i
  return [] if s * s == n
  b = 1
  results = [[a,b,c]]
  r = -1
  loop do
    a, b, c = coefficients(n, s, b, c)
    results << [a, b, c]
    break if results.size == r
    if r < 0 && results.index(results.last) != results.size - 1
      r = results.size - 2
      if r % 2 == 0
        results.pop
        results.pop
        break
      else
        r = 2 * r
        if results.size > r
          results.pop
          break
        end
      end
    end
  end
  results
end

# returns the basic solution, [x, y], to the equation x^2 - n*y^2 = 1
def solve_pell(n)
  return [0, 0] if Math.sqrt(n).to_i ** 2 == n
  sequence = continued(n).reverse
  
  bottom = sequence.shift[0]
  top = 1
  sequence.each do |x|
    x = x[0]
    top += x * bottom
    top, bottom = bottom, top
  end

  return cancel_factors(bottom, top)
end

# returns all solutions for x^2 - n*y^2 = 1 where the passed block for x and y returns true
def pell_multiples(n)
  x, y = solve_pell(n)
  x1 = x2 = x
  y1 = y2 = y
  solutions = [[x, y]]
  while(yield(x2, y2)) do
    x2 = x * x1 + n * y * y1
    y2 = x * y1 + y * x1
    solutions << [x2, y2]
    x1, y1 = x2, y2
  end
  solutions
end
