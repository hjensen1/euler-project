require './functions.rb'

@ch = [7, 22, 36]
@cc = [2, 17, 33]
@jail = 10
@g2jail = 30
@ch_cards = [0, 10, 11, 24, 39, 5, "R", "R", "U", "B"]
@cc_cards = [0, 10]
@cur = 0
@doubles = 0
@counts = Array.new(40){0}

def roll(n)
  d1 = (Random.rand * n + 1).to_i
  d2 = (Random.rand * n + 1).to_i
  if d1 == d2
    @doubles += 1
  else
    @doubles = 0
  end
  if @doubles == 3
    @cur = @jail
    @doubles = 0
    @counts[@jail] += 1
    return
  end
  @cur = (@cur + d1 + d2) % 40
  if @cur == @g2jail
    @cur = @jail
  elsif @ch.include?(@cur)
    card = @ch_cards[(Random.rand * 16).to_i]
    if card.class == Fixnum
      @cur = card
    elsif card == "R"
      @cur = (@cur % 10 >= 5 ? (@cur / 5 * 5 + 10) : (@cur / 5 * 5 + 5)) % 40
    elsif card == "U"
      if @cur > 12 && @cur < 28
        @cur = 28
      else
        @cur = 12
      end
    elsif card == "B"
      @cur -= 3
    end
  end
  if @cc.include?(@cur)
    card = @cc_cards[(Random.rand * 16).to_i]
    if card.class == Fixnum
      @cur = card
    end
  end
  @counts[@cur] += 1
end

10000000.times do
  roll(4)
end

hash = {}
@counts.each_with_index do |x, i|
  puts "#{i}: #{x / 100000.0}%"
  hash[x] = i
end

puts hash.keys.sort.reverse[0,3].map{ |x| hash[x] }

Timer.print
