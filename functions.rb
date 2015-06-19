
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

