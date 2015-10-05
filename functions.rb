require 'openssl'

# returns a list of all primes up to limit using seive of eratothenes
def prime_sieve(limit)
  numbers = (0..limit).to_a
  cancel = Array.new(numbers.size) { |i| i > 1 }
  numbers.each_with_index do |x, i|
    if cancel[i]
      (2..(limit / x)).each do |j|
        cancel[j * x] = false
      end
    end
  end
  primes = []
  numbers.each_with_index do |x, i|
    primes << x if cancel[i]
  end
  primes
end

@counts_for_partitions = {}

# returns the number of ways to split n identical items into groups
def partitions(n)
  if n == 0 || n == 1
    return 1
  elsif n < 0
    return 0
  elsif @counts_for_partitions[n]
    return @counts_for_partitions[n]
  else
    sum = 0
    (1..n).each do |k|
      break if (k * (3 * k - 1)) / 2 > n
      sign = (-1) ** (k + 1)
      p1 = partitions(n - (k * (3 * k - 1)) / 2)
      p2 = partitions(n - (k * (3 * k + 1)) / 2)
      sum += sign * (p1 + p2)
    end
    @counts_for_partitions[n] = sum
    return sum
  end
end

def coin_partitions(x, maximum = x, options = (1..x).to_a, recursive = false)
  unless recursive && options == @options_for_coin_partitions
    @counts_for_coin_partitions = {} unless recursive
    @options_for_coin_partitions = options
  end
  min = options.first
  maximum = x if maximum > x
  if x <= 0
    return maximum == 0 ? 1 : 0
  elsif x < min || maximum < min
    return 0
  elsif maximum == min
    return x % min == 0 ? 1 : 0
  elsif @counts_for_coin_partitions[[x, maximum]]
    return @counts_for_coin_partitions[[x, maximum]]
  else
    count = 0
    options.each do |p|
      break if p > maximum
      count += coin_partitions(x - p, p, options, true)
    end
    @counts_for_coin_partitions[[x, maximum]] = count
    return count
  end
end


# this is a quick pseudoprime test with 100% accuracy for numbers into the billions
# unfortunately, just binary searching the prime_list is faster for numbers with those bounds
def miller_rabin(n)
  s = n - 1
  r = 0
  while s % 2 == 0
    r += 1
    s /= 2
  end
  [2, 7, 61].each do |a|
    x = a.to_bn.mod_exp(s, n)
    next if x == 1 || x == n - 1
    check = false
    (r - 1).times do
      x = (x * x) % n
      return false if x == 1
      if x == n - 1
        check = true
        break
      end
    end
    return false unless check
  end
  return true
end

#solves linear diophantine equations with coefficients of a and b
def diophantine(a, b)
  swap = false
  if a > b
    a, b = b, a
    swap = true
  end
  x = a
  y = b
  z = a % b
  coefs = [x, y, z]
  loop do
    x, y, z = y, z, y % z
    coefs << z
    if z == 1
      break
    end
  end
  coefs.reverse!
  x = 0
  coefs.each_with_index do |c1, i|
    break if i == coefs.size - 1
    c2 = coefs[i + 1]
    x = (1 - x * c2) / c1
  end
  y = (1 - x * b) / a
  x, y = y, x if swap
  return y, x
end

# removes all common factors from both x and y and returns both results
def cancel_factors(x, y)
  prime_list.each do |p|
    while x % p == 0 && y % p == 0
      x /= p
      y /= p
      break if p > x || p > y
    end
  end
  return x, y
end

# convenience method / backwards compatibility for accessing the primes list
def prime_list
  return Primes.prime_list
end

class Primes
  @pages = 1
  @prime_list = []
  # reads a list of primes from primes.txt files and returns it in an array
  # reads only primes1.txt normally (first 1 million primes)
  # set Primes.pages to a different value to read more millions
  def self.prime_list(force_update = false)
    return @prime_list unless @prime_list.empty? && !force_update
    @prime_list = []
    (1..@pages).each do |i|
      File.open("primes#{i}.txt") do |file|
        while (!file.eof?)
          line = file.readline
          parts = line.split(' ')
          parts.each do |s|
            @prime_list << s.to_i unless s.empty? || s.to_i == 0
          end
        end
      end
    end
    Timer.start
    @prime_list
  end
  
  def self.set_pages(p)
    @pages = p
    self.prime_list(true)
  end
end

# takes a string or other input and returns whether it is a palindrome
def is_palindrome(input, downcase = false)
  input = "#{input}" if input.class == Fixnum || input.class == Float || input.class == Bignum
  (0...(input.length / 2)).each do |i|
    if downcase
      return false if input[i].downcase != input[-(i + 1)].downcase
    else
      return false if input[i] != input[-(i + 1)]
    end
  end
  return true
end

def read_input(name, split = ',', gsub = '"')
  a = File.open(name) do |file|
    result = file.readlines
    result.each_index do |i|
      result[i] = result[i].strip.split(split).map{|s| s.gsub(gsub, '')}
    end
    result
  end
end

# returns a list of all pythagorean triples where c^2 is at most max
def pythagorean_triples(max, include_multiples = true)
  triples = []
  numbers = Factors.enumerate(1, Math.sqrt(max).to_i).sort
  numbers.each_with_index do |n, i|
    (0...i).each do |j|
      m = numbers[j]
      if (n % 2 == 0 || m % 2 == 0) && (n.factors.keys - m.factors.keys).size == n.factors.size
        a = n * n - m * m
        b = 2 * n * m
        c = n * n + m * m
        triples << [a, b, c]
      end
    end
  end
  if include_multiples
    multiples = []
    triples.each do |t|
      (2..(max/t[2])).each do |i|
        multiples << [t[0] * i, t[1] * i, t[2] * i]
      end
    end
    triples += multiples
  end
  triples
end

def xor_encode(input, code)
  input = input.unpack("C*") if input.class == String
  code = code.unpack("C*") if code.class == String
  decoded = []
  input.each_with_index do |x, i|
    decoded << (x ^ code[i % code.size])
  end
  decoded.pack("C*")
end

@word_list = nil

def word_list
  @word_list ||= read_input('english_words.txt', ' ', '').flatten
end

@dcs = [31,28,31,30,31,30,31,31,30,31,30,31]
@day_names = ['Sunday', 'Monday', "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

# takes a date string formated dd/mm/yyyy and returns the day of the week
# currently only works for days > 1/1/1900
def day_of_week(date)
  parts = date.split /[-\/]/
  month = parts[0].to_i
  day = parts[1].to_i
  year = parts[2].to_i
  current = 0 # at Jan 1, 1900

  (1900...year).each do |y|
    current += 365
    current += 1 if (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0))
  end
  (1...month).each do |m|
    current += @dcs[m - 1]
    current += 1 if m == 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
  end
  current += day
  return @day_names[current % 7]
end

def combine_digits(list, base = 10)
  sum = 0
  list.each do |i|
    sum *= base
    sum += i
  end
  sum
end

# returns the number of unique ways to add to n, using the numbers in the list
def ways_to_sum(n, list)
  return 1 if n == 0
  return 0 if list.empty?
  count = 0
  (0..(n / list[0])).each do |i|
    count += ways_to_sum(n - list[0] * i, list[1, list.length])
  end
  return count
end

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
    return {self => 1} if is_prime?
    n = self
    factors = Hash.new(0)
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

class Timer
  def self.start
    @start_time = Time.now
  end
  
  def self.stop
    @stop_time = Time.now
  end
  
  def self.print(start = @start_time, stop = @stop_time)
    stop ||= Time.now
    puts "Took #{(stop.to_f - start.to_f).round(4)} seconds."
  end
  
  def self.mark(num)
    @marks ||= {}
    @marks[num] = Time.now
  end
end

# a class for generating lists of numbers which are pre-factored
# this list will not be in numerical order, as they are generated
# systematically to eliminate time spent calculating factors
class Factors
  attr_accessor :factors
  attr_accessor :value
  
  def initialize(n, factors = nil)
    @value = n
    @factors = factors ? factors : n.factorize
  end
  
  def method_missing(symbol, *args)
    args.empty? ? @value.send(symbol) : @value.send(symbol, *args)
  end
  
  def **(n)
    value = @value ** n
    factors = Hash.new(0)
    @factors.each_pair do |k, v|
      factors[k] = v * n
    end
    Factors.new(value, factors)
  end
  
  def enumerate_factors(min = 1, max = @value)
    factors = Hash.new(0)
    n = 1
    indices = []
    i = 0
    results = min <= 1 ? [1] : []
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
        results << n
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
  
  def to_s
    @value.to_s
  end
  
  def inspect
    @value.inspect
  end
  
  def <=>(other)
    if other.class == Factors
      @value <=> other.value
    else
      @value <=> other
    end
  end
  
  def coerce(other)
    [other, self.value]
  end
end

Timer.start

