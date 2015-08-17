class WorkspaceBuilder

  def self.build name
    Resque.enqueue(RallyWorkspace, {name: name, queue: name})
    puts "queue'd workspace #{name}"
  end

  private
  
  new

end
