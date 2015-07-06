require './functions.rb'

@hash = Hash.new{ |h, k| h[k] = [] }
(0...2000).each do |i|
  p1 = prime_list[i]
  (0...i).each do |j|
    p2 = prime_list[j]
    a1 = combine_digits(p1.digits + p2.digits)
    a2 = combine_digits(p2.digits + p1.digits)
    if a1.is_prime? && a2.is_prime?
      @hash[p1] << p2
      @hash[p2] << p1
    end
  end
end

def solve(result)
  return result if result.size == 5
  iterate = result.first ? @hash[result.first] : prime_list[0, 2000]
  iterate.each do |x|
    check = true
    result.each do |y|
      if !@hash[y].binclude?(x) || !@hash[x].binclude?(y)
        check = false
        break
      end
    end
    next unless check
    result << x
    a = solve(result)
    if a
      return a
    else
      result.pop
    end
  end
  return false
end

result = solve([])
Timer.print
puts result.to_s
puts result.sum
