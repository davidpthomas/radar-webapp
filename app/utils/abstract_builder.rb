# Base class for workspace builders containing common utility methods
class AbstractBuilder
  def generate_name
    NameGenerator.generate(@prefix)
  end

  def now(klass, params)
    Resque.enqueue(klass, params)
  end
end


