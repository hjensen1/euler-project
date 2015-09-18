require './functions.rb'

puts (2.to_bn.mod_exp(7830457, 10**10) * 28433 + 1) % (10**10)

Timer.print
