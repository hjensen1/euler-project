require './functions.rb'

top = 1
bot = 2
count = 0

1000.times do
  d1 = (bot + top).digits.size
  d2 = bot.digits.size
  count += 1 if d1 > d2
  top, bot = bot, (top + 2 * bot)
end

puts count

Timer.print
