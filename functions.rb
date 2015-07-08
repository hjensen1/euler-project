require 'openssl'

# returns a list of all primes up to limit using seive of eratothenes
def prime_sieve(limit)
  primes = []
  (2..limit).each do |i|
    composite = false
    primes.each do |p|
      if i % p == 0
        composite = true
        break
      end
    end
    next if composite
    primes << i
  end
  return primes
end

# returns a list of the first n primes using seive of eratothenes
def prime_sieve2(limit)
  primes = []
  i = 1
  while (primes.size < limit) do
    i += 1
    composite = false
    primes.each do |p|
      if i % p == 0
        composite = true
        break
      end
    end
    next if composite
    primes << i
  end
  return primes
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
      result[i] = result[i].split(split).map{|s| s.gsub(gsub, '')}
    end
    result
  end
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
    self.inject(start){ |a, b| a + b}
  end

  def product(start = 1)
    self.inject(start){ |a,b| a * b }
  end

  def binclude?(n)
    return self.bsearch{ |x| x >= n } == n
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
    n = self
    factors = Hash.new(0)
    i = 0
    while (n > 1) do
      p = Primes.prime_list[i]
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

prime_list
Timer.start

