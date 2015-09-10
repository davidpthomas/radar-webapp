require 'rally_api'

class RallyWorkspace < RallyWorker

  @queue = :rallyworkspace

  def self.work(params)
Rails.logger.info params.inspect
    Rails.logger.info "[#{@queue}]: Creating Workspace '#{params["name"]}'}"

    # default required parameters
    params[:state] = 'Open'

    create("workspace", params)

  end

end
