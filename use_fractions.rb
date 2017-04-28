# Note: Turning on use_fractions may have unpredictable results in code not designed for it
#       It also slows down even normal division by a factor of 3, so use with caution

class Fixnum
  alias_method :divide, :/
  
  def /(other)
    if self.class.use_fractions && other.is_a?(Fixnum)
      if (self.divide(other) * other == self)
        self.divide(other)
      else
        Fraction.reduce(self, other)
      end
    else
      self.divide(other)
    end
  end
  
  class << self
    attr_accessor :use_fractions
    @use_fractions = false
  end
end
