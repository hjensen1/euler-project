require './functions.rb'

class Roman
  TO_NUMBERS = { "I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000 }
  TO_CHARS = TO_NUMBERS.invert
  attr_accessor :value
  
  def initialize(value)
    if value.class == Fixnum
      @value = value
    else
      @value = parse(value)
    end
  end
  
  def method_missing(symbol, *args)
    args.empty? ? @value.send(symbol) : @value.send(symbol, *args)
  end
  
  def +(other)
    if other.class == Roman
      Roman.new(other.value + @value)
    else
      Roman.new(other + @value)
    end
  end
  
  def -(other)
    if other.class == Roman
      Roman.new(@value - other.value)
    else
      Roman.new(@value - other)
    end
  end
  
  def coerce(other)
    [Roman.new(other), self]
  end
  
  def parse(string)
    numbers = []
    (0...string.size).each do |i|
      numbers << TO_NUMBERS[string[i]]
    end
    total = 0
    last = 1000
    numbers.each do |n|
      total -= 2 * last if n > last
      total += n
      last = n
    end
    total
  end
  
  def to_s
    values = [1000, 100, 10, 1]
    string = @value < 0 ? "-" : ""
    values.each_with_index do |x, i|
      n = @value < 0 ? -@value / x % 10 : @value / x % 10
      if n == 9 && x < 1000
        string << TO_CHARS[x] << TO_CHARS[x * 10]
      elsif n == 4 && x < 1000
        string << TO_CHARS[x] << TO_CHARS[x * 5]
      else
        if n >= 5 && x < 1000
          string << TO_CHARS[x * 5]
          n -= 5
        end
        n.times do
          string << TO_CHARS[x]
        end
      end
    end
    string
  end
  
  def inspect
    to_s
  end
end

numbers = read_input('input_89.txt').flatten
diff = 0
numbers.each do |n|
  diff += n.size - Roman.new(n).to_s.size rescue (puts Roman.new(n).value)
end

puts diff

Timer.print
