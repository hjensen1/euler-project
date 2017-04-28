class Fraction
  include Comparable
  
  class << self
    @always_reduce = true
    attr_accessor :always_reduce
  end
  attr_accessor :top, :bottom
  
  def self.reduce(top, bottom)
    fraction = Fraction.new(top, bottom)
    fraction.is_integer? ? fraction.to_i : fraction
  end
  
  def initialize(top, bottom = 1)
    @top = top
    @bottom = bottom
    reduce
  end
  
  def reduce
    n = gcd(@top, @bottom)
    n *= -1 if @bottom < 0
    @top /= n
    @bottom /= n
    self
  end
  
  def to_s
    "#{@top}/#{@bottom}"
  end
  
  def inspect
    to_s
  end
  
  def to_f
    top.to_f / bottom
  end
  
  def to_i
    to_f.to_i
  end
  
  def is_integer?
    @bottom == 1
  end
  
  def ==(other)
    to_f == other
  end
  
  def +(other)
    if other.is_a?(Fraction)
      top1 = @top * other.bottom
      bottom = @bottom * other.bottom
      top2 = other.top * @bottom
      Fraction.reduce(top1 + top2, bottom)
    elsif other.is_a?(Integer)
      other + self
    else
      to_f + other
    end
  end
  
  def *(other)
    if other.is_a?(Fraction)
      Fraction.reduce(@top * other.top, @bottom * other.bottom)
    elsif other.is_a?(Integer)
      other * self
    else
      to_f * other
    end
  end
  
  def -(other)
    self + (-1 * other)
  end
  
  def /(other)
    if other.is_a?(Fraction)
      Fraction.reduce(@top * other.bottom, @bottom * other.top)
    elsif other.is_a?(Integer)
      Fraction.new(@top, @bottom * other)
    else
      to_f + other
    end
  end
  
  def <=>(other)
    to_f <=> other.to_f
  end
  
  def **(exp)
    result = 1
    exp.times do
      result *= self
    end
    result
  end
  
  def abs
    Fraction.new(top.abs, bottom)
  end
  
  def inverse
    Fraction.new(@bottom, @top)
  end
  
  def coerce(other)
    [Fraction.new(other), self]
  end
end
