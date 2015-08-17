class WorkspaceBuilderFactory

  # create an instance of the given workspace builder e.g. :online_store
  def self.create type
    begin
      # given a symbol name, return an instance of the associated builder class
      # e.g.  :online_store ==> OnlineStoreBuilder
      klass = type.to_s.camelize
      klass_builder = "#{klass}Builder"
      k = Class.const_get(klass_builder)
      k.new
    rescue Exception => e
      raise "Unsupported workspace type #{type}"
    end
  end

  # Convenience method: create then build
  def self.build type
    builder = self.create(type)
    builder.build
  end
end

