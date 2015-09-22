require 'rally_api'
require 'rally_cache_manager'

class PortfolioItemFeature < Worker

  def self.work(params)

    job_id = params['job_id']
    #workspace_name = params['workspace']
    project_name = params['project']

    project = RallyCacheManager.find_by_name(job_id, project_name)
    project_ref = project['ref']

    preliminary_estamate = RallyEnumManager.find_by_name("preliminaryestimate", "L")

Rails.logger.info "GOT PRELIM: #{preliminary_estimate.inspect}"

    if params.has_key?('parent')
      project_cache = RallyCacheManager.find_by_name(job_id, params['parent'])
      parent_ref = project_cache['ref']
    end

    params['parent'] = parent_ref
    params['project'] = project_ref

    feature = create("portfolioitem/feature", params)

  end

end
