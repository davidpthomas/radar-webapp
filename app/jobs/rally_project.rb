require 'rally_api'

class RallyProject < RallyWorker

    @queue = :rallyproject

  def self.work(params)

    name = params['name']
    parent = params['parent']
    workspace = params['workspace']

    Rails.logger.info "[#{@queue}]: Creating Project #{name}"
    begin
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "subscription", :fetch => "Name,Workspaces"}))

      idx = results[0].Workspaces.find_index {|w| w.Name == workspace}

      workspace_ref = results[0].Workspaces[idx]._ref
      ws = {"_ref" => workspace_ref}
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "project", :workspace => ws, :query_string => "( Name = \"#{parent}\" )"}))
      parent_ref = results.first
      Rails.logger.info "Found Parent Project: #{parent} #{parent_ref}"

    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

    obj = {}
    obj[:name] = name
    obj[:state] = 'Open'
    obj[:parent] = parent_ref
    obj[:workspace] = workspace_ref

    begin
      new_obj = @rally.create("project", obj)
      Rails.logger.info " >> created project #{name} [#{parent}] [#{workspace}]"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

  end

end
