require './functions.rb'

list = []

(10..99).each do |a|
  (a..99).each do |b|
    da = a.digits
    db = b.digits
    list << [a,b] if da[0].to_f / db[1].to_f == a.to_f / b.to_f && da[0] != da[1] &&
      (da[0] == db[1] || db[0] == da[1])
  end
end

puts "#{list}"
a = list.inject(1){ |x, y| x * y[0] }
b = list.inject(1){ |x, y| x * y[1] }
af = a.factorize
bf = b.factorize

result = 1
bf.each do |k, v|
  t = [bf[k] - af[k], 0].max
  t.times do
    result *= k
  end
end

puts result
