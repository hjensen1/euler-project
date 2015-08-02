require './functions.rb'

def coefficients(n, s, b, c, results = [])
  b1 = (n - c * c) / b
  a1 = (s + c) / b1
  c1 = (a1 * b1) - c
  return a1, b1, c1
end

def period(n)
  a = s = c = Math.sqrt(n).to_i
  return 0 if s * s == n
  b = 1
  results = [[a,b,c]]
  loop do
    a, b, c = coefficients(n, s, b, c, results)
    results << [a, b, c]
    break unless results.index(results.last) == results.size - 1
  end
  results.size - results.index(results.last) - 1
end

count = 0
(1..10000).each do |n|
  count += 1 if period(n) % 2 == 1
end

puts count
Timer.print
