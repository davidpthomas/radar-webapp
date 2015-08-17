class OnlineStoreBuilder < AbstractBuilder

  def initialize
    @prefix = "Online Store"
  end

  def build
    name = generate_name
    puts "Building #{name}"

    workspace({name: name})
    project({name: "#{name}, Inc.", workspace: name})

  end

end
