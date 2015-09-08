require './functions.rb'

denoms = [1,2,5,10,20,50,100,200]

puts coin_partitions(200, 200, denoms)

Timer.print
