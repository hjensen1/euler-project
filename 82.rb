require './functions.rb'
require 'set'

rows = read_input("input_83.txt")
rows.each do |row|
  row.map!(&:to_i)
end

width = rows.size
height = rows[0].size
memo = Array.new(width){ Array.new(height) }

frontier = Hash.new{ |h, k| h[k] = [] }
values = SortedSet.new
(0...height).each do |i|
  frontier[rows[i][0]] << [i, 0]
  memo[i][0] = rows[i][0]
  values.add(rows[i][0])
end

check = true
while check
  value = values.first
  is = frontier[value].pop
  [[is[0]+1, is[1]], [is[0]-1, is[1]], [is[0], is[1]+1]].each do |indices|
    x, y = indices
    next if x < 0 || y < 0 || x >= width || y >= height || memo[x][y]
    memo[x][y] = rows[x][y] + value
    frontier[memo[x][y]] << [x, y]
    values.add(memo[x][y])
    if y == width - 1
      puts memo[x][y]
      check = false
    end
  end
  values.delete(value) if frontier[value].empty?
end

Timer.print
