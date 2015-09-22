require 'rally_api'
require 'rally_cache_manager'

class Project < Worker

  def self.work(params)

    job_id = params['job_id']
    workspace_name = params['workspace']

    workspace = RallyCacheManager.find_by_name(job_id, workspace_name)
    workspace_ref = workspace['ref']

    if params.has_key?('parent')
      project_cache = RallyCacheManager.find_by_name(job_id, params['parent'])
      parent_ref = project_cache['ref']
    end

    params['state'] = 'Open'
    params['parent'] = parent_ref
    params['workspace'] = workspace_ref

    Rails.logger.info "Creating Project #{name}"

    begin
      project = create("project", params)
      Rails.logger.info " >> created project #{project.Name} [#{project.parent}]"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

  end

end
