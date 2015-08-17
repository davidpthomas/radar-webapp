require 'rally_api'

class RallyStoryCreate < RallyWorker

    @queue = :rallyproject

  def self.work(params)

    name = params['name']
    project = params['project']
    feature = params['feature']
    workspace = params['workspace']

    Rails.logger.info "[#{@queue}]: Creating Story #{name}"
    begin
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "subscription", :fetch => "Name,Workspaces"}))

      idx = results[0].Workspaces.find_index {|w| w.Name == workspace}

      workspace_ref = results[0].Workspaces[idx]._ref
      ws = {"_ref" => workspace_ref}
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "project", :workspace => ws, :query_string => "( Name = \"#{project}\" )"}))
      project_ref = results.first
      Rails.logger.info "Found Project: #{project} #{project_ref}"

      results = @rally.find(RallyAPI::RallyQuery.new({:type => "portfolioitem/feature", :workspace => ws, :query_string => "( Name = \"#{feature}\" )"}))
      feature_ref = results.first._ref
      Rails.logger.info "Found Feature: #{feature} #{feature_ref}"

    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

    obj = {}
    obj[:name] = name
    obj[:portfolioitem] = feature_ref
    obj[:project] = project_ref
    begin
      new_obj = @rally.create("story", obj)
      Rails.logger.info " >> created story #{name} [#{project}] [#{workspace}]"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

  end

end
