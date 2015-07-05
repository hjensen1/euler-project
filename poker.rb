require './functions.rb'

class PokerHand
  include Comparable
  HANDS =  ["Straight Flush", "Four of a Kind", "Full House", "Flush", "Straight",
            "Three of a Kind", "Two Pairs", "Pair", "High Card"]
	attr_reader :cards
  
  def initialize(strings)
    strings = strings.split(" ") if strings.class == "".class
    @cards = []
    strings.each do |s|
      @cards << PokerCard.new(s)
    end
    @cards.sort!
    fail("Hand must have exactly 5 cards (has: #{@cards.size}).") unless @cards.size == 5
  end
  
  def <=> other
    self.hand_value.each_with_index do |item, i|
      next if other.hand_value[i] == item
      return i == 0 ? HANDS.index(item) <=> HANDS.index(other.hand_value[i]) : other.hand_value[i] <=> item
    end
    return 0
  end
  
  def hand_value
    return @hand_value if @hand_value
    @hand_value = []
    @counts = get_counts
    inverted = @counts.invert
    if is_straight? && is_flush?
      @hand_value << "Straight Flush"
      if @cards.first.number == 2 && @cards.last.number == 14
        @hand_value << @cards[3].number
      else
        @hand_value << @cards.last.number
      end
      @hand_value << "Straight Flush - #{PokerCard.name(@hand_value[1])} High"
    elsif @counts.values.max == 4
      @hand_value << "Four of a Kind"
      @hand_value << inverted[4]
      @hand_value << inverted[1]
      @hand_value << "Four of a Kind - #{PokerCard.name(@hand_value[1], true)}"
    elsif @counts.values.include?(3) && @counts.values.include?(2)
      @hand_value << "Full House"
      @hand_value << inverted[3]
      @hand_value << inverted[2]
      @hand_value << "Full House - #{PokerCard.name(@hand_value[1], true)} over #{PokerCard.name(@hand_value[2], true)}"
    elsif is_flush?
      @hand_value << "Flush"
      @hand_value += @cards.reverse.map(&:number)
      @hand_value << "Flush - #{PokerCard.name(@hand_value[1])} High"
    elsif is_straight?
      @hand_value << "Straight"
      if @cards.first.number == 2 && @cards.last.number == 14
        @hand_value << @cards[3].number
      else
        @hand_value << @cards.last.number
      end
      @hand_value << "Straight - #{PokerCard.name(@hand_value[1])} High"
    elsif @counts.values.include?(3)
      @hand_value << "Three of a Kind"
      @hand_value << inverted[3]
      @hand_value += (@counts.keys - [inverted[3]]).sort.reverse
      @hand_value << "Three of a Kind - #{PokerCard.name(@hand_value[1], true)}"
    elsif @counts.values.count(2) == 2
      @hand_value << "Two Pairs"
      @hand_value += (@counts.keys - [inverted[1]]).sort.reverse
      @hand_value << inverted[1]
      @hand_value << "Two Pairs - #{PokerCard.name(@hand_value[1], true)} and #{PokerCard.name(@hand_value[2], true)}"
    elsif @counts.values.include?(2)
      @hand_value << "Pair"
      @hand_value << inverted[2]
      @hand_value += (@counts.keys - [inverted[2]]).sort.reverse
      @hand_value << "One Pair - #{PokerCard.name(@hand_value[1], true)}"
    else
      @hand_value << "High Card"
      @hand_value += @cards.reverse.map(&:number)
      @hand_value << "#{PokerCard.name(@hand_value[1])} High"
    end
    @hand_value
  end
  
  def is_straight?
    prev = @cards[0].number - 1
    @cards.each do |c|
      n = prev
      prev = c.number
      next if n == 5 && c.number == 14
      return false unless n == c.number - 1
    end
    return true
  end
  
  def is_flush?
    suit = @cards[0].suit
    @cards.each do |c|
      return false unless c.suit == suit
    end
    return true
  end
  
  def get_counts
    hash = Hash.new(0)
    cards.each do |c|
      hash[c.number] += 1
    end
    hash
  end
  
  def to_s
    "#<#{hand_string}  cards: #{@cards.to_s}>"
  end
  
  def inspect
    self.to_s
  end
  
  def hand_string
    result = hand_value.last
  end
end

class PokerCard
  include Comparable
  BYTES = {
    50 => 2, 51 => 3, 52 => 4, 53 => 5, 54 => 6, 55 => 7, 56 => 8, 57 => 9,
    84 => 10, 74 => 11, 81 => 12, 75 => 13, 65 => 14
  }
  SUITS = {
    'S' => 'Spades', 'C' => 'Clubs', 'H' => 'Hearts', 'D' => 'Diamonds'
  }
  NAMES = {
    2 => 'Two', 3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six', 7 => 'Seven',
    8 => 'Eight', 9 => 'Nine', 10 => 'Ten', 11 => 'Jack', 12 => 'Queen',
    13 => 'King', 14 => 'Ace'
  }
  attr_reader :number
  attr_reader :suit
  
  # format found in input_54.txt
  def initialize(string)
    @number = BYTES[string.getbyte(0)]
    @suit = SUITS[string[1]]
  end
  
  def <=> other
    self.number <=> other.number
  end
  
  def to_s
    "#{NAMES[@number]} of #{@suit}"
  end
  
  def inspect
    self.to_s
  end
  
  def self.name(number, plural = false)
    number = 14 if number == 1
    result = NAMES[number]
    result += number == 6 ? "es" : "s" if plural
    result
  end
end