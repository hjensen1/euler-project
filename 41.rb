require './functions.rb'

check = [1,2,3,4,5,6,7]

prime_list.reverse.each do |p|
  next if p > 8000000
  if p.digits.sort == check
    puts p
    break
  end
end
