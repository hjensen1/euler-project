require './functions.rb'

list = read_input('input_99.txt').map{ |x| Math.log(x[0].to_i) * x[1].to_i }
puts list.index(list.sort.last) + 1

Timer.print
