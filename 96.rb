require './functions.rb'

class Sudoku
  attr_accessor :rows
  attr_accessor :numbers
  
  def initialize(rows)
    @rows = rows.dup
    numbers = Array.new(9) { Array.new(9) }
    (0...9).each do |i|
      (0...9).each do |j|
        numbers[i][j] = NumberPlace.new(@rows[i][j], i, j)
      end
    end
    @groups = []
    (0...9).each do |i|
      row = []
      column = []
      (0...9).each do |j|
        row << numbers[i][j]
        column << numbers[j][i]
      end
      @groups << row
      @groups << column
    end
    (0...3).each do |x|
      (0...3).each do |y|
        box = []
        (0...3).each do |i|
          (0...3).each do |j|
            box << numbers[3 * x + i][3 * y + j]
          end
        end
        @groups << box
      end
    end
    @groups.each do |group|
      group.each do |number|
        number.groups << group
      end
    end
    numbers.flatten!
    numbers.each do |n|
      n.init_possibilities
    end
    numbers.sort!
    @numbers = numbers
  end
  
  def solve
    @numbers.sort!
    return true if @numbers.first.val != 0
    return false if @numbers.first.possible.size == 0
    number = @numbers.first
    possible = number.possible.dup
    possible.each do |p|
      number.val = p
      changed = []
      number.groups.each do |group|
        group.each do |n|
          if n.possible.include?(p)
            changed << n
            n.possible.delete(p)
          end
        end
      end
      if solve
        return true
      else
        number.val = 0
        changed.each do |n|
          n.possible << p
        end
      end
    end
    return false
  end
  
  def solve_all
    solve
    @numbers.each do |number|
      @rows[number.x][number.y] = number.val
    end
  end
  
  def to_s
    s = ""
    @rows.each do |r|
      r.each do |n|
        s << "#{n} "
      end
      s << "\n"
    end
    s
  end
  
  class NumberPlace
    attr_accessor :val
    attr_accessor :groups
    attr_accessor :possible
    attr_accessor :x
    attr_accessor :y
    
    def initialize(value, x, y)
      @val = value
      @groups = []
      @possible = []
      @x = x
      @y = y
    end
    
    def init_possibilities
      if @val == 0
        @possible = [1,2,3,4,5,6,7,8,9]
        @groups.each do |group|
          group.each do |n|
            @possible.delete(n.val) unless n.val == 0
          end
        end
      else
        @possible << val
      end
    end
    
    def <=>(other)
      if @val != 0
        1
      elsif other.val != 0
        -1
      else
        @possible.size <=> other.possible.size
      end
    end
    
    def inspect
      @val
    end
  end
end

sudokus = []
File.open('input_96.txt') do |file|
  lines = file.readlines
  rows = []
  (0..lines.size).each do |i|
    if i == lines.size || lines[i].start_with?("Grid")
      unless i == 0
        rows2 = []
        offset = '0'.getbyte(0)
        rows.each do |row|
          row2 = []
          (0...9).each do |j|
            row2 << (row.getbyte(j) - offset)
          end
          rows2 << row2
        end
        sudokus << Sudoku.new(rows2)
      end
      rows = []
    else
      rows << lines[i]
    end
  end
end

total = 0
sudokus.each do |s|
  s.solve_all
  total += combine_digits(s.rows[0][0, 3])
end

puts total
Timer.print
