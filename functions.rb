
def is_prime(n)
  return prime_list.bsearch{|x| x >= n} == n
end

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

# convenience method for accessing the primes list
def prime_list
  return Primes.prime_list
end

class Primes
  @prime_list = []
  # reads a list of primes from primes.txt and returns it in an array
  def self.prime_list
    return @prime_list unless @prime_list.empty?
    File.open('primes.txt') do |file|
      while (!file.eof?)
        line = file.readline
        parts = line.split(' ')
        parts.each do |s|
          @prime_list << s.to_i unless s.empty? || s.to_i == 0
        end
      end
    end
    @prime_list
  end
end

# takes a string or other input and returns whether it is a palindrome
def is_palindrome(input, downcase = false)
	input = "#{input}" if input.class == Fixnum || input.class == Float
	(0...(input.length / 2)).each do |i|
		if downcase
			return false if input[i].downcase != input[-(i + 1)].downcase
		else
			return false if input[i] != input[-(i + 1)]
		end
	end
	return true
end

def read_input(name)
  a = File.open(name) do |file|
  	file.readlines.first.split(',').map{|s| s.gsub('"', '')}
  end
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

def combine_digits(list)
  sum = 0
  list.each do |i|
    sum *= 10
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
  def is_prime
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

  def ^(y)
    prod = 1
    y.times do
      prod *= self
    end
    prod
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

end
