require './functions.rb'
require './use_fractions.rb'

Fixnum.use_fractions = true
@un = Polynomial.parse("1-n+n^2-n^3+n^4-n^5+n^6-n^7+n^8-n^9+n^10")
@xs = (1..11).to_a
@ys = (1..11).map { |x| @un.evaluate(n: x) }

def interpolate(xs, ys)
  terms = []
  ys.each_with_index do |yi, i|
    top = yi
    bottom = 1
    xs.each_with_index do |xj, j|
      unless i == j
        top *= Polynomial.parse("x-#{xj}")
        bottom *= (xs[i] - xj)
      end
    end
    terms << (top / bottom)
  end
  Polynomial.new(terms)
end

@functions = [Polynomial.parse("#{@ys[0]}")]
(2..10).each do |i|
  @functions << interpolate(@xs.first(i), @ys.first(i))
  puts @functions.last
end

sum = 0
@functions.each_with_index do |f, i|
  sum += f.evaluate(x: i + 2)
end
puts sum

Timer.print
