
string = "
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"

a1 = string.split(" ").map{|s| s.to_i}
a = []
sums = []
n = 1
i = 0
while i < a1.length
  a2 = []
  sum2 = []
  n.times do 
    a2 << a1[i]
    sum2 << 0
    i += 1
  end
  a << a2
  sums << sum2
  n += 1
end

sums[0][0] = a[0][0]
(1...a.length).each do |i|
  row = a[i]
  (0...row.length).each do |j|
    left = j == 0 ? 0 : sums[i - 1][j - 1]
    right = j == row.length - 1 ? 0 : sums[i - 1][j]
    sums[i][j] = a[i][j] + [left, right].max
  end
end

puts sums.last.max
