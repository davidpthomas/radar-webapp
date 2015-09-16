require 'rally_api'

class RallyWorkspace < RallyWorker

  @queue = :rallyworkspace

  def self.work(params)

    # default required parameters
    params[:state] = 'Open'

    create("workspace", params)

  end

end
