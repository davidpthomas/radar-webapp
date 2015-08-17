require 'rally_api'

class RallyStoryUpdate < RallyWorker

    @queue = :rallyproject

  def self.work(params)

    name = params['name']
    project = params['project']
    schedule_state = params['schedule_state']
    workspace = params['workspace']

    Rails.logger.info "[#{@queue}]: Updating Story #{name} - #{schedule_state}"
    begin
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "subscription", :fetch => "Name,Workspaces"}))

      idx = results[0].Workspaces.find_index {|w| w.Name == workspace}

      workspace_ref = results[0].Workspaces[idx]._ref
      ws = {"_ref" => workspace_ref}
      results = @rally.find(RallyAPI::RallyQuery.new({:type => "project", :workspace => ws, :query_string => "( Name = \"#{project}\" )"}))
      project_ref = results.first
      Rails.logger.info "Found Project: #{project} #{project_ref}"

      results = @rally.find(RallyAPI::RallyQuery.new({:type => "story", :project => project_ref, :query_string => "( Name = \"#{name}\" )"}))
      story = results.first

      fields = {}
      fields["ScheduleState"] = "In-Progress"

      story.update(fields)
      Rails.logger.debug "Updated Story [#{story}] with fields [#{fields.inspect}]"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end
exit
    obj = {}
    obj[:name] = name
    obj[:feature] = feature_ref
    obj[:project] = project_ref

    begin
      new_obj = @rally.create("story", obj)
      Rails.logger.info " >> created story #{name} [#{project}] [#{workspace}]"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

  end

end
