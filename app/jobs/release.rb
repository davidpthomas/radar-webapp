require 'rally_api'
require 'rally_cache_manager'

class Release < Worker

  @queue = :rallyproject

  def self.work(params)

    job_id = params['job_id']
    project_name = params['project']

    project_cache = RallyCacheManager.find_by_name(job_id, project_name)
    project_ref = project_cache['ref']

    params['project'] = project_ref

    Rails.logger.info "[#{@queue}]: Creating Release #{params['name']}"

    begin
      release = create("release", params)
      Rails.logger.info " >> created release #{release.Name}"
    rescue Exception => e
      Rails.logger.info "Error: #{e.message}"
    end

  end

end
