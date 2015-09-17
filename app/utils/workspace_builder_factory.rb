class WorkspaceBuilderFactory

  # Given the (string) name of a builder, create an instance and build.
  # - e.g. given 'onlinestore' create OnlineStoreBuilder instance and build it
  def self.build type
    builder = self.create(type)
    builder.build
  end

  private

  # Creates an instance of a builder by converting the given string name
  # into a Class by convention (e.g. onlinestore -> OnlineStoreBuilder)
  def self.create type
    begin
      # given a symbol name, return an instance of the associated builder class
      # e.g.  :online_store ==> OnlineStoreBuilder
      klass = type.to_s.camelize
      klass_builder = "#{klass}Builder"
      k = Class.const_get(klass_builder)
      k.new
    rescue Exception => e
      raise "Unsupported workspace type #{type}."
    end
  end


end

