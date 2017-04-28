require './fraction.rb'

class Polynomial
  class << self
    attr_accessor :space_terms
    @space_terms = true
    
    def parse(s)
      s.gsub!(" ", "")
      terms = []
      term = nil
      operator = "add"
      i = 0
      while i < s.length do
        c = s[i]
        if c == "("
          in_parens = find_right_paren(s[i + 1, s.length])
          add_term(terms, parse(in_parens), operator)
          operator = "add"
          i += in_parens.length + 1
        elsif c == "-" || c == "+"
          add_term(terms, term, operator)
          operator = "add"
          terms << c
          term = nil
        elsif /\d/.match(c)
          num_string = /\d+/.match(s[i, s.length])[0]
          num = num_string.to_i
          if operator == "exponent"
            add_term(terms, num, operator)
            operator = "add"
          elsif term.nil?
            term = Term.new(num)
          elsif term.vars.empty?
            raise ArgumentError.new("Digits appear at an invalid location")
          else
            term.vars[s[i - 2].to_sym] = (term.vars[s[i - 2].to_sym] - 1 || 0) + num
          end
          i += num_string.length - 1
        elsif /[a-zA-Z]/.match(c)
          term = Term.new(1) if term.nil?
          sym = c.to_sym
          term.vars[sym] = (term.vars[sym] || 0) + 1
        elsif c == "*"
          add_term(terms, term, operator)
          term = nil
          operator = "multiply"
        elsif c == "^"
          operator = "exponent" if term.nil?
        end
        i += 1
      end
      add_term(terms, term, operator)
      combine_terms(terms)
    end
    
    def add_term(terms, term, operator)
      return unless term
      if operator == "multiply"
        terms[terms.size - 1] = terms.last * term
      elsif operator == "exponent"
        if term.is_a?(Integer)
          result = 1
          term.times do
            result *= terms.last
          end
          terms[terms.size - 1] = result
        else
          terms.last.vars.values.map! { |e| e * term }
        end
      else
        terms << term
      end
    end
    
    def combine_terms(terms)
      result = 0
      sign = "+"
      terms.each do |term|
        if term == "+" || term == "-"
          sign = term
        elsif sign == "+"
          result += term
        else
          result -= term
        end
      end
      result
    end
    
    def find_right_paren(s)
      lparens = 1
      s.length.times do |i|
        lparens += 1 if s[i] == "("
        lparens -= 1 if s[i] == ")"
        return s[0, i] if lparens == 0
      end
      raise ArgumentError.new("Unbalanced parentheses")
    end
  end
  
  attr_accessor :terms
  
  def initialize(terms)
    @terms = terms
    @terms = [Term.new(0)] if terms.nil? || terms.empty?
    if @terms.any? { |term| term.is_a?(Polynomial) }
      @terms = @terms.sum.terms
    end
    @terms.sort!
    combine_like_terms
  end
  
  def combine_like_terms
    results = []
    prev = terms.first
    @terms[1, @terms.length].each do |term|
      if term.can_add?(prev)
        prev = prev + term
      else
        results << prev unless prev.coef == 0
        prev = term
      end
    end
    results << prev unless prev.coef == 0
    @terms = results
    @terms = [Term.new(0)] if terms.nil? || terms.empty?
  end
  
  def to_s
    result = terms.first.inspect
    space = self.class.space_terms ? " " : ""
    terms[1, terms.length].each do |term|
      result += "#{space}#{term.sign}#{space}#{term.to_s}"
    end
    result
  end
  
  def inspect
    to_s
  end
  
  def +(other)
    if other.is_a?(Polynomial)
      Polynomial.new(terms + other.terms)
    elsif other.is_a?(Term)
      Polynomial.new(terms + [other])
    elsif is_number_class?(other)
      Polynomial.new(terms + [Term.new(other)])
    end
  end
  
  def *(other)
    if other.is_a?(Polynomial)
      polynomial_multiply(other)
    elsif other.is_a?(Term) || is_number_class?(other)
      Polynomial.new(terms.map { |term| term * other })
    end
  end
  
  def polynomial_multiply(other)
    terms = []
    @terms.each do |t1|
      other.terms.each do |t2|
        terms << t1 * t2
      end
    end
    Polynomial.new(terms)
  end
  
  def -(other)
    self + (other * -1)
  end
  
  def /(other)
    Polynomial.new(@terms.map { |t| t / other} )
  end
  
  def evaluate(values)
    poly = Polynomial.new(terms.map { |term| term.evaluate(values) })
    poly.is_number? ? poly.to_i : poly
  end
  
  def is_number?
    @terms.size == 1 && @terms.first.vars.size == 0
  end
  
  def to_i
    @terms.first.coef
  end
  
  def coerce(other)
    [Term.new(other), self]
  end
end

class Term
  EXP_CODES = ["\u2070", "\u00B9", "\u00B2", "\u00B3", "\u2074", "\u2075", "\u2076", "\u2077", "\u2078", "\u2079"]
  attr_accessor :coef, :vars
  
  def initialize(coef, vars = {})
    @coef = coef
    @vars = vars
    @vars.reject! { |k, v| v == 0 }
  end
  
  def to_s
    abs_string
  end
  
  def inspect
    (coef < 0 ? "-" : "") + abs_string
  end
  
  def get_exponent_string(x)
    return "" if x == 1
    if x.is_a?(Integer)
      x.digits.map { |d| EXP_CODES[d] }.join("")
    else
      "^(#{x})"
    end
  end
  
  def sign
    coef < 0 ? "-" : "+"
  end
  
  def abs_string
    result = @coef.abs.to_s
    result = "" if result == "1" && !vars.empty?
    @vars.each_pair do |v, e|
      result += "#{v}#{get_exponent_string(e)}"
    end
    result
  end
  
  def dup
    Term.new(@coef, @vars.dup)
  end
  
  def *(term)
    if is_number_class?(term)
      Term.new(@coef * term, @vars)
    elsif term.is_a?(Term)
      coef = @coef * term.coef
      vars = @vars.merge(term.vars)
      @vars.each_pair do |v, e|
        if term.vars[v] && term.vars[v] != 0
          vars[v] += @vars[v]
        end
      end
      Term.new(coef, vars)
    elsif term.is_a?(Polynomial)
      term * self
    end
  end
  
  def +(term)
    if is_number_class?(term)
      self + Term.new(term)
    elsif term.is_a?(Polynomial)
      term + self
    elsif term.is_a?(Term)
      if can_add?(term)
        Term.new(@coef + term.coef, @vars)
      else
        Polynomial.new([self, term])
      end
    end
  end
  
  def -(term)
    self + (term * -1)
  end
  
  # TODO allow division by non-numbers
  def /(term)
    if is_number_class?(term)
      if @coef.is_a?(Integer) && term.is_a?(Integer) && @coef % term != 0 && !Fixnum.use_fractions
        term = term.to_f
      end
      Term.new(@coef / term, @vars)
    else
      raise ArgumentError.new("Attempting to divide a term by a non-number.")
    end
  end
  
  def <=>(term)
    term = Term.new(term) if is_number_class?(term)
    keys = @vars.merge(term.vars).keys.sort
    keys.each do |key|
      return 1 if @vars[key].nil? && term.vars[key]
      return -1 if term.vars[key].nil? && @vars[key]
      return 1 if @vars[key] < term.vars[key]
      return -1 if @vars[key] > term.vars[key]
    end
    0
  end
  
  def evaluate(values)
    coef = @coef
    vars = @vars.dup
    values.each_pair do |var, value|
      if vars[var]
        coef *= (value ** vars[var])
        vars.delete(var)
      end
    end
    Term.new(coef, vars)
  end
  
  def can_add?(term)
    term.vars.size == @vars.size && @vars.keys.all? { |v| term.vars[v] == @vars[v] }
  end
  
  def coerce(other)
    [Term.new(other), self]
  end
end

def is_number_class?(object)
  object.is_a?(Integer) || object.is_a?(Float) || object.is_a?(Fraction)
end

