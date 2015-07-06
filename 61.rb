require './functions.rb'

lists = [[],[],[],[],[],[]]

(1..1000).each do |n|
  if !lists[0].last || lists[0].last < 10000
    a = n * (n + 1) / 2
    lists[0] << a if a > 999
  end
  if !lists[1].last || lists[1].last < 10000
    a = n * n
    lists[1] << a if a > 999
  end
  if !lists[2].last || lists[2].last < 10000
    a = n * (3 * n - 1) / 2
    lists[2] << a if a > 999
  end
  if !lists[3].last || lists[3].last < 10000
    a = n * (2 * n - 1)
    lists[3] << a if a > 999
  end
  if !lists[4].last || lists[4].last < 10000
    a = n * (5 * n - 3) / 2
    lists[4] << a if a > 999
  end
  if !lists[5].last || lists[5].last < 10000
    a = n * (3 * n - 2)
    lists[5] << a if a > 999
  end
  break if lists[0].last && lists[0].last > 9999
end

dls = lists.flatten.sort.map(&:digits)
@lists = lists

def solve(dls, result)
  if result.size == 6
    return false unless result.last[2, 2] == result.first[0, 2]
    a = Hash.new{ |h, k| h[k] = [] }
    @lists.each_with_index do |l, i|
      check = false
      result.each do |x|
        if l.binclude?(combine_digits(x))
          check = true
          a[i] = combine_digits(x)
        end
      end
      return false unless check
    end
    return a.values.flatten.uniq.size == 6 ? result.map{ |x| combine_digits(x) } : false
  end
  dls.each do |x|
    if result.empty? || result.last[2, 2] == x[0, 2]
      result << x
      check = solve(dls, result)
      return check if check
      result.pop
    end
  end
  return false
end

result = solve(dls, [])

Timer.print
puts result.to_s
puts result.sum

# a = Hash.new{ |h, k| h[k] = [] }
# result.each do |x|
#   lists.each_with_index do |l, i|
#     a[x] << i if l.binclude?(x)
#   end
# end
# 
# puts a
