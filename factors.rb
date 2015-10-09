
# a class for generating lists of numbers which are pre-factored
# this list will not be in numerical order, as they are generated
# systematically to eliminate time spent calculating factors
class Factors
  @@factor_arithmetic = false
  
  attr_accessor :factors
  attr_accessor :value
  
  def initialize(n, factors = nil)
    @value = n
    @factors = factors || n.factorize
  end
  
  def method_missing(symbol, *args)
    if args.empty?
      @value.send(symbol)
    elsif args.size == 1
      other = args.first
      if other.class == Factors
        @value.send(symbol, other.value)
      else
        @value.send(symbol, *args)
      end
    else
      @value.send(symbol, *args)
    end
  end
  
  def **(n)
    value = @value ** n
    factors = Hash.new(0)
    @factors.each_pair do |k, v|
      factors[k] = v * n
    end
    Factors.new(value, factors)
  end
  
  def enumerate_factors(min = 1, max = @value, use_factors = false)
    use_factors ||= @@factor_arithmetic
    factors = Hash.new(0)
    n = 1
    indices = []
    i = 0
    results = min <= 1 ? [use_factors ? Factors.new(1) : 1] : []
    loop do
      p = @factors.keys[i]
      if !p || factors[p] >= @factors[p]
        i += 1
        p = @factors.keys[i]
      end
      if p && n * p <= max
        n *= p
        factors[p] += 1
        indices << i
        next if n < min
        results << (use_factors ? Factors.new(n, factors.dup) : n)
      else
        break if indices.empty?
        p = @factors.keys[indices.last]
        n /= p
        factors[p] -= 1
        i = indices.pop + 1
      end
    end
    results
  end
  
  def self.enumerate(first, last)
    factors = Hash.new(0)
    n = 1
    indices = []
    i = 0
    results = first <= 1 ? [Factors.new(1)] : []
    loop do
      p = Primes.prime_list[i]
      break if p > last
      if n * p <= last
        n *= p
        factors[p] += 1
        indices << i
        next if n < first
        results << Factors.new(n, factors.dup())
      else
        p = prime_list[indices.last]
        n /= p
        if factors[p] == 1
          factors.delete(p)
        else
          factors[p] -= 1
        end
        i = indices.pop + 1
      end
    end
    results
  end
  
  def /(other, use_factors = false)
    if other.class == Factors && (@@factor_arithmetic || use_factors)
      value = @value / other.value
      factors = {}
      @factors.each_pair do |f, count|
        count2 = other.factors[f]
        if count - count2 >= 0
          factors[f] = count - count2 if count - count2 > 0
        else
          return value
        end
      end
      other.factors.each_pair do |f, count|
        return value if @factors[f] == 0
      end
      Factors.new(value, factors)
    else
      @value / other
    end
  end
  
  def *(other, use_factors = false)
    if other.class == Factors && (@@factor_arithmetic || use_factors)
      value = @value * other.value
      factors = {}
      @factors.each_pair do |f, count|
        count2 = other.factors[f]
        factors[f] = count + count2
      end
      other.factors.each_pair do |f, count|
        factors[f] = count unless @factors[f] > 0
      end
      Factors.new(value, factors)
    else
      @value * other
    end
  end
  
  def to_s
    @value.to_s
  end
  
  def inspect
    @value.inspect
  end
  
  def coerce(other)
    [other, self.value]
  end
  
  def self.set_factor_arithmetic(b)
    @@factor_arithmetic = b
  end
  
  def is_prime?
    @factors.size == 1 && @factors.first[1] == 1
  end
  
  def factorize
    @factors
  end
  
  def all_factors
    enumerate_factors
  end
  
  def ==(other)
    if other.class == Factors
      @value == other.value
    else
      @value == other
    end
  end
end
