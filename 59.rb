require './functions.rb'

input = read_input('input_59.txt').first.map{ |s| s.to_i }

base = 'a'.getbyte(0)
test = 'qwertyuiopasdfghjklzxcvbnm QWERTYUIOPASDFGHJKLZXCVBNM'.unpack('C*').sort

(base..(base + 25)).each do |i|
  (base..(base + 25)).each do |j|
    (base..(base + 25)).each do |k|
      code = [i, j, k]
      string = xor_encode(input, code)
      bytes = string.unpack("C*")
      if string.include?(" the ")
        puts string
        puts code.pack('C*')
        puts bytes.sum
      end
    end
  end
end

Timer.print
