require './functions.rb'

hash = {}
small_hash = {}
included = []
sum = 0

prime_list.each do |p|
  puts sum if sum % 100 == 0
  small_hash.each do |i, v|
    break if sum >= 500500
    if v < p
      sum += 1
      hash[i][0] *= 2
      hash[i][1] = i ** hash[i][0]
      if hash[i][1] > 16000000
        small_hash.delete(i)
      else
        small_hash[i] = hash[i][1]
      end
    end
  end
  break if sum >= 500500
  sum += 1
  included << p
  hash[p] = [2, p * p]
  small_hash[p] = hash[p][1] if hash[p][1] < 16000000
end

result = 1
included.each do |p|
  (hash[p][0] - 1).times do
    result *= p
    result = result % 500500507 if result >= 500500507
  end
end

puts result

Timer.print
