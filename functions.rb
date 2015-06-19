
# takes an int and returns a hash of its prime factors to the number of times they occur
def factorize(to_factor)
	factors = Hash.new(0)
	i = 2
	while (to_factor > 1) do
		if to_factor % i == 0
			factors[i] += 1
			to_factor /= i
		else
			i += 1
		end
	end
	return factors
end

# takes an int and returns a list of all factors in order from smallest to largest
def all_factors(to_factor)
  limit = Math.sqrt(to_factor)
  small = []
  large = []
  (1..(limit.to_i)).each do |i|
    next unless to_factor % i == 0
    small << i
    large << to_factor / i unless i == limit
  end
  small + large.reverse
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
		puts i
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

@prime_list = []
# reads a list of primes from primes.txt and returns it in an array
def prime_list
  return @prime_list unless @prime_list.empty?
  File.open('primes.txt') do |file|
    while (!file.eof?)
      line = file.readline
      parts = line.split(',')
      parts.each do |s|
        @prime_list << s.to_i unless s.empty? || s.to_i == 0
      end
    end
  end
  @prime_list
end

# takes a string or other input and returns whether it's to_s is a palindrome
def is_palindrome(input, downcase = false)
	input = "#{input}"
	(0...(input.length / 2)).each do |i|
		if downcase
			return false if input[i].downcase != input[-(i + 1)].downcase
		else
			return false if input[i] != input[-(i + 1)]
		end
	end
	return true
end

@ntw = {
	0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
	6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
	11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen',
	16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen', 20 => 'twenty',
	30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty',
	90 => 'ninety', 100 => 'hundred', 1000 => 'thousand', 1000000 => 'million', 1000000000 => 'billion',
	1000000000000 => 'trillion', 1000000000000000 => 'quadrillion'
}

# takes a number less than 1 quintillion and returns that number spelled out in words
def number_to_words(n, recursive = false)
	start = n
	order = [1000000000000000, 1000000000000, 1000000000, 1000000, 1000]
	parts = []
	order.each do |i|
		if n >= i
			parts << number_to_words(n / i, true) << @ntw[i]
			n = n % i
		end
	end
	if n >= 100
		parts << @ntw[n / 100] << @ntw[100]
		n = n % 100
	end
	if n > 0 && start > 100 && !recursive
		parts << 'and'
	end
	if n <= 20
		parts << @ntw[n] unless n == 0
	else
		parts << "#{@ntw[n - n % 10]}#{n % 10 == 0 ? "" : "-#{@ntw[n % 10]}"}"
	end
	parts.join(" ")
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

def factorial(n)
  return (1..n).to_a.inject(1){ |a, b| a * b }
end

