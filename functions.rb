require 'openssl'
require './factors.rb'
require './fixnum.rb'
require './array.rb'
require './timer.rb'

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

# iterates through all combinations of n items from the list
# assuming the list is sorted, the resulting arrays will be sorted as well
# returns the number of combinations iterated
def iterate_combinations(list, n, dup = false)
  result = [list.first]
  indices = [0]
  count = 0
  loop do
    if result.size == n
      yield(dup ? result.dup : result)
      count += 1
      if indices[0] == list.size - n
        break
      else
        if indices.last == list.size - 1
          indices.pop
          result.pop
        end
        indices[indices.size - 1] += 1
        result[result.size - 1] = list[indices.last]
      end
    else
      if indices.last == list.size - n + indices.size
        indices.pop
        result.pop
        indices[indices.size - 1] += 1
        result[result.size - 1] = list[indices.last]
      else
        indices << indices.last + 1
        result << list[indices.last]
      end
    end
  end
  count
end

def iterate_orderings(list1)
  list = list1.dup
  even = true
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


Timer.start

