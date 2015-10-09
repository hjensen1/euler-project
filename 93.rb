require './functions.rb'

@methods = [:+, :-, :*, :/]

def parse(string)
  parts = string.split('').map do |s|
    f = s.to_f
    f > 0 ? f : s
  end
  
end

def solutions(a, b, c, d, m1, m2, m3, hash)
  hash[  ]
end

Timer.print
