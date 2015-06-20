require './functions.rb'

hash = {}
base = {}

(2..100).each do |a|
  base[a] = a.factorize
end

(2..100).each do |a|
  (2..100).each do |b|
    h = base[a].dup
    h.each do |k, v|
      h[k] *= b
    end
    hash[h] = [a,b]
  end
end

puts hash.size
