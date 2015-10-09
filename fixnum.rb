
class Fixnum
  def is_prime?
    if self > Primes.prime_list.last
      sqrt = Math.sqrt(self)
      Primes.prime_list.each do |p|
        break if p > sqrt
        return false if self % p == 0
      end
      return true
    end
    return Primes.prime_list.bsearch{|x| x >= self} == self
  end
  
  def digits(base = 10)
    n = self
    list = []
    while n > 0
      list << n % base
      n /= base
    end
    list.reverse
  end

  # returns a hash of its prime factors to the number of times they occur
  def factorize
    n = self
    factors = Hash.new(0)
    if is_prime?
      factors[n] = 1
      return factors
    end
    i = 0
    while (n > 1) do
      p = Primes.prime_list[i]
      if i >= Primes.prime_list.size
        if n > Primes.prime_list.last * Primes.prime_list.last
          puts "Error: can't factorize large primes"
        else
          factors[n] += 1
          break
        end
      end
      if n % p == 0
        factors[p] += 1
        n /= p
      else
        i += 1
      end
    end
    return factors
  end

  # takes an int and returns a list of all factors in order from smallest to largest
  def all_factors
    return [1, self] if self.is_prime?
    limit = Math.sqrt(self)
    small = []
    large = []
    (1..(limit.to_i)).each do |i|
      next unless self % i == 0
      small << i
      large << self / i unless i == limit
    end
    small + large.reverse
  end

  NTW = {
    0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
    6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
    11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen',
    16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen', 20 => 'twenty',
    30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty',
    90 => 'ninety', 100 => 'hundred', 1000 => 'thousand', 1000000 => 'million', 1000000000 => 'billion',
    1000000000000 => 'trillion', 1000000000000000 => 'quadrillion'
  }

  # takes a number less than 1 quintillion and returns that number spelled out in words
  def to_words(recursive = false)
    n = self
    start = n
    order = [1000000000000000, 1000000000000, 1000000000, 1000000, 1000]
    parts = []
    order.each do |i|
      if n >= i
        parts << (n / i).to_words(true) << NTW[i]
        n = n % i
      end
    end
    if n >= 100
      parts << NTW[n / 100] << NTW[100]
      n = n % 100
    end
    if n > 0 && start > 100 && !recursive
      parts << 'and'
    end
    if n <= 20
      parts << NTW[n] unless n == 0
    else
      parts << "#{NTW[n - n % 10]}#{n % 10 == 0 ? "" : "-#{NTW[n % 10]}"}"
    end
    parts.join(" ")
  end

  def factorial
    return (1..self).to_a.inject(1){ |a, b| a * b }
  end
  
  def c(y)
    self.factorial / y.factorial / (self - y).factorial
  end
  
  # euler's totient function (phi)
  # returns the number of integers less than self which are relatively prime to it.
  def totient
    factors = self.factorize.keys
    result = self
    factors.each do |f|
      result = result * (f - 1) / f
    end
    result
  end
  
  def is_square?
    return Math.sqrt(self).to_i ** 2 == self
  end
end

class Bignum
  def digits(base = 10)
    n = self
    list = []
    while n > 0
      list << n % base
      n /= base
    end
    list.reverse
  end
end
