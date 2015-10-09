
class Array
  def sum(start = 0)
    self.inject(start, :+)
  end

  def product(start = 1)
    self.inject(start, :*)
  end

  def binclude?(n)
    return self.bsearch{ |x| x >= n } == n
  end
  
  def combinations(n)
    combos = []
    array = [self.first]
    inds = [0]
    i = 1
    loop do
      if array.size == n
        combos << array.dup
        array.pop
        i = inds.pop + 1
      elsif i >= self.size
        break if inds[0] == self.size - 1 || inds.empty?
        array.pop
        i = inds.pop + 1
      else
        array << self[i]
        inds << i
        i += 1
      end
    end
    combos
  end
end
