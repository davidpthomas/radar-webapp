require 'rally_api'

class RallyWorkspace < RallyWorker

  @queue = :rallyworkspace

  def self.work(params)
#    @queue = params['queue']
    name = params['name']

    Rails.logger.info "[#{@queue}]: Creating Workspace '#{name}'}"

    obj = {}
    obj[:name] = name
    obj[:state] = 'Open'

    begin
      new_obj = @rally.create("workspace", obj)
      Rails.logger.info " >> created workspace #{name}"
    rescue Exception => e
      puts "Error: #{e.message}"
    end

  end

end
