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
