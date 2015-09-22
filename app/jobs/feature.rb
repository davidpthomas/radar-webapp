require 'rally_api'

class Feature < Worker

  def self.work(params)

    name = params['name']
    project = params['project']
    workspace = params['workspace']

    Rails.logger.info "Creating Feature #{name}"
    begin
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "subscription", :fetch => "Name,Workspaces"}))

      idx = results[0].Workspaces.find_index {|w| w.Name == workspace}

      workspace_ref = results[0].Workspaces[idx]._ref
      ws = {"_ref" => workspace_ref}
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "project", :workspace => ws, :query_string => "( Name = \"#{project}\" )"}))
      project_ref = results.first

      Rails.logger.info "Found Project: #{project} #{project_ref}"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

    obj = {}
    obj[:name] = name
    obj[:project] = project_ref

    begin
      new_obj = @rally.create("portfolioitem/feature", obj)
      Rails.logger.info " >> created feature #{name} [#{project}] [#{workspace}]"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

  end

end
