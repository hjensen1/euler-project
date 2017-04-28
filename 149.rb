require './functions.rb'

@width = 2000
@height = 2000

def generate
  result = []
  (1..(@width * @height)).each do |k|
    if k <= 55
      result << (100_003 - 200_003 * k + 300_007 * k * k * k) % 1_000_000 - 500_000
    else
      result << (result[k - 25] + result[k - 56] + 1_000_000) % 1_000_000 - 500_000
    end
  end
  result
end

def find
  @array[@width * @j + @i]
end

@array = generate
# @width = 4
# @height = 4
# @array = [-2,5,3,2,9,-6,5,1,3,2,7,3,-1,8,-4,8]

def compute_max_substring(x, y)
  @i = x
  @j = y
  best = 0
  current = 0
  while (@i >= 0 && @j >= 0 && @i < @width && @j < @height)
    current += find
    best = current if current > best
    current = 0 if current < 0
    yield
  end
  best
end

best = 0
@width.times do |i|
  options = [
    compute_max_substring(0, i) { @i += 1 },
    compute_max_substring(0, i) { (@i += 1) && (@j += 1) },
    compute_max_substring(0, i) { (@i -= 1) && (@j += 1) },
    compute_max_substring(i, 0) { @j += 1 },
    compute_max_substring(i, 0) { (@i += 1) && (@j += 1) },
    compute_max_substring(@width - 1, i) { (@i -= 1) && (@j += 1) }
  ]
  max = options.max
  best = max if max > best
end

puts best

Timer.print
