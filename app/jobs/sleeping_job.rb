class SleepingJob

  def self.queue
    :fooqueue
  end
  def self.perform
    puts "Foobar."
    sleep 2
  end
end
