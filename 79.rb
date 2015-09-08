require './functions.rb'

# this solution assumes each digit appears only once. This is obviously true in the example,
# and a more general solution seems much harder to implement
list = read_input("input_79.txt").flatten
hash = Hash.new{ |h, k| h[k] = [[],[]] }

list.each do |s|
  hash[s[1]][0] << s[0] unless hash[s[1]][0].include?(s[0])
  hash[s[1]][1] << s[2] unless hash[s[1]][1].include?(s[2])
end

string = ""
while !hash.empty?
  k = hash.keys.first
  while hash.include?(k)
    k = hash[k][0].first
  end
  string << k
  hash.each_pair do |x, v|
    v[0].delete(k)
    v[1].delete(k)
    if v[0].empty?
      hash.delete(x)
    end
    string << x if hash.empty?
    string << v[1][0] if hash.empty?
  end
end

puts string

Timer.print
