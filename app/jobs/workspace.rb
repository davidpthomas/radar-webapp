require 'rally_api'

class Workspace < Worker

  @queue = :rallyworkspace

  def self.work(params)

    # default required parameters
    params[:state] = 'Open'

    create("workspace", params)

  end

end
