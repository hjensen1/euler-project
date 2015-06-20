require './functions.rb'

@digits = [1,2,3,4,5,6,7,8,9]

@results = []

def recur(list)
  if (list.size >= 5)
    a = combine_digits(list[0,2])
    b = combine_digits(list[2,5])
    c = a * b
    ds = c.digits
    @results << c if (list + ds).sort == @digits
    a = combine_digits(list[0,1])
    b = combine_digits(list[1,5])
    c = a * b
    ds = c.digits
    @results << c if (list + ds).sort == @digits
    return
  end
  @digits.each do |d|
    unless list.include?(d)
      list << d
      recur(list)
      list.pop
    end
  end
end

recur([])

@results.uniq!

puts "#{@results}"
puts @results.inject(0){ |a,b| a + b }
