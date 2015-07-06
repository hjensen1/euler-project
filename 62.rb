require './functions.rb'


list1 = []
(101..10000).each do |x|
  list1 << x * x * x
end
hash = {}
list1.each do |x|
  dc = x.digits.size
  if hash[dc]
    hash[dc] << x
  else
    hash[dc] = [x]
  end
end
hash.each_pair do |k, list|
  list2 = list.map{ |x| combine_digits(x.digits.sort) }.sort
  count = 1
  prev = 0
  results = []
  list2.each do |x|
    if (x == prev)
      count += 1
    else
      count = 1
    end
    prev = x
    results << x if count == 5
    results.pop if count == 6
  end
  puts results.to_s
  next if results.empty?
  check = false
  list.each do |x|
    if (results.binclude?(combine_digits(x.digits.sort)))
      check = true
      puts x
      break
    end
  end
  break if check
end

Timer.print
