require './functions.rb'

primes = prime_list.reject{ |x| x < 1000 || x > 10000}

primes.each_with_index do |p, i|
  list = []
  ds = p.digits.sort
  ((i + 1)...primes.length).each do |j|
    p2 = primes[j]
    list << p2 if ds == p2.digits.sort
  end
  next if list.size < 2
  diffs = list.map{ |a| a - p }
  diffs.each_with_index do |d, j|
    ((j + 1)...diffs.length).each do |k|
      if diffs[k] / 2 == d
        puts combine_digits(p.digits + list[j].digits + list[k].digits)
      end
    end
  end
end

Timer.print
