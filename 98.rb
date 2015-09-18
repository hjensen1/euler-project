require './functions.rb'

def anagram_groups(all_words)
  groups = Hash.new{ |h, k| h[k] = [] }
  all_words.each do |word|
    groups[word.split("").sort.sum("")] << word
  end
  groups.select{ |x| groups[x].size > 1 }
end

def anagram_diffs(anagram_groups)
  diffs = {}
  anagram_groups.each_pair do |key, group|
    group.each do |x|
      group.each do |y|
        next if x == y
        map = {}
        (0...x.size).each do |i|
          map[x.getbyte(i)] = i unless map[x.getbyte(i)]
        end
        string = ""
        (0...y.size).each do |i|
          string << map[y.getbyte(i)].to_s
        end
        if diffs[string].nil? || diffs[string][0] < x
          diffs[string] = [x, y]
        end
      end
    end
  end
  diffs
end

all_words = read_input('input_98.txt').first

groups = anagram_groups(all_words)
letter_counts = {}
groups.each_pair do |a, words|
  letters = Hash.new(0)
  words.first.split('').each do |c|
    letters[c] += 1
  end
  letter_counts[letters.values.sort] = 1
end

squares = []
(1..100000).each do |x|
  n = x * x
  letters = Hash.new(0)
  n.digits.each do |c|
    letters[c] += 1
  end
  squares << n.to_s if letter_counts[letters.values.sort]
end
square_groups = anagram_groups(squares)

diffs = anagram_diffs(groups)
square_diffs = anagram_diffs(square_groups)

matches = {}
diffs.each_pair do |k, v|
  values = square_diffs[k]
  if values
    matches[v] = values
  end
end

puts matches.inspect
puts matches.values.flatten.map(&:to_i).max

Timer.print
