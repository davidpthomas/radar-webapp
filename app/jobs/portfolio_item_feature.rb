require 'rally_api'
require 'rally_cache_manager'

class PortfolioItemFeature < Worker

  def self.work(params)

    #workspace_name = params['workspace']
    project_name = params['project']

    project = RallyCacheManager.find_by_name(@job_id, project_name)
    project_ref = project['ref']

    preliminary_estimate = RallyEnumManager.find_by_name(@job_id, "preliminaryestimate", "L")
    Rails.logger.info "BAR***** #{preliminary_estimate.inspect}"
    preliminary_estimate_ref = preliminary_estimate['ref']

    if params.has_key?('parent')
      project_cache = RallyCacheManager.find_by_name(@job_id, params['parent'])
      parent_ref = project_cache['ref']
    end

    params['parent'] = parent_ref
    params['project'] = project_ref
    params['preliminaryestimate'] = preliminary_estimate_ref
Rails.logger.info "CREATING FEATURE: #{params.inspect}"
    feature = create("portfolioitem/feature", params)

  end

end
