require './functions.rb'

counts = {145 => 1, 169 => 3, 363601 => 3, 1454 => 3, 871 => 2,
          45361 => 2, 872 => 2, 45362 => 2, 1 => 1, 2 => 1}
count = 0

(1..1000000).each do |x|
  val = x
  (0..60).each do |i|
    if counts[val]
      counts[x] = i + counts[val]
      break
    end
    val = val.digits.map(&:factorial).sum
  end
  if counts[x] == 60
    count += 1
  elsif !counts[x]
    counts[x] = 100
  end
end

puts count
Timer.print
