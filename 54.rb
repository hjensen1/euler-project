require './poker.rb'

a = read_input('input_54.txt', ' ', '')
count = 0
a.each do |line|
  p1 = PokerHand.new(line[0,5])
  p2 = PokerHand.new(line[5,5])
  puts "#{p1.hand_string} #{p1 < p2 ? ">" : "<"} #{p2.hand_string}"
  count += 1 if p1 < p2
end

puts count
