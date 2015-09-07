require './functions.rb'

def all_solutions(n)
  inside = []
  outside = []
  all_numbers = (1..(2 * n)).to_a
  n2 = 2 * n
  i = 1
  solutions = []
  loop do
    if inside.size == n
      solution = check(inside, all_numbers - inside)
      solutions << solution if solution && !solutions.include?(solution)
      i = inside.pop + 1
    elsif i > n2
      break if inside.empty?
      i = inside.pop + 1
    else
      loop do
        if i > n2
          break
        elsif !inside.include?(i)
          inside << i
          i = 1
        else
          i += 1
        end
      end
    end
  end
  solutions
end

def check(inside, outside)
  sums = []
  (-1..(inside.size - 2)).each do |i|
    sums << inside[i] + inside[i + 1]
  end
  l1 = sums.sort
  min = l1.first
  (0...l1.size).each do |i|
    l1[i] -= min
  end
  l2 = outside.sort.reverse
  max = l2.first
  (0...l2.size).each do |i|
    l2[i] = max - l2[i]
  end
  if l1 == l2
    hash = {}
    sums.sort.reverse.each_with_index do |sum, i|
      hash[sum] = outside[i]
    end
    results = []
    (-1..(inside.size - 2)).each do |i|
      sum = inside[i] + inside[i + 1]
      results << [hash[sum], inside[i], inside[i + 1]]
    end
    min = results.map{ |a| a[0] }.min
    while results[0][0] != min
      results.unshift(results.pop)
    end
    results
  end
end

solutions = all_solutions(5)
puts solutions.map{ |x| x.flatten.map(&:to_s).inject(""){ |a, y| a += y }.to_i }.select{ |x| x < 10 ** 16}.sort.last

Timer.print
