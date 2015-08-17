class NameGenerator

  def self.generate(name)
    r = Random.new
    return "#{name} - #{r.rand(1000)}"
  end

  private

  def new
  end

end
