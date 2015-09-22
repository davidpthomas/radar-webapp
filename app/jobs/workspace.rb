require 'rally_api'

class Workspace < Worker

  def self.work(params)

    # default required parameters
    params[:state] = 'Open'

    create("workspace", params)

  end

end
