require 'rally_connection'

class RallyEnumManager

  def self.find_by_name(job_id, type, name)
    query = { job_id: job_id, artifact_type: type, name: name}
    # look in db cache first
    cache = RallyEnumCache.find_by(query)
    Rails.logger.info "GOT ENUM CACHE: #{cache.inspect}"
    # not cached locally, go fetch from rally
    if cache.nil?
      Rails.logger.info "Local ENUM Cache empty."
      cache = self.lookup(job_id, type, name)
    end
    cache
  end

  private

  def self.lookup(job_id, type, name)

    rally = RallyConnection.connect

    workspace_cache = RallyCacheManager.find_workspace_by_job(job_id)
    workspace_ref = workspace_cache['ref']

    query = RallyAPI::RallyQuery.new()
    query.type = type
    query.query_string = "(Name = \"#{name}\" )"
    query.fetch = "Name,Value"
    query.workspace = {"_ref" => workspace_ref}

    Rails.logger.info "Query: #{query}"
    Rails.logger.info "Rally Lookup: #{type} - #{name}"
    results = rally.find(query)
    
    result = results.first
    Rails.logger.info "Rally Lookup Result: #{result.inspect}"
    cache = self.cache(job_id, type, result.name, result.Value, result._ref)
    Rails.logger.info "Rally Lookup Cache: #{cache.inspect}"
    cache
  end

  def self.cache(job_id, type, name, value, ref)
    cache_obj = { job_id: job_id, artifact_type: type, name: name, value: value, ref: ref } 
    begin
      cache = RallyEnumCache.create(cache_obj) 
      Rails.logger.info "Cached: [type|#{cache.artifact_type}] - [name|#{cache.name}] - [value|#{cache.value}]"
    rescue Exception => e
      Rails.logger.error "Unable to cache #{cache_obj}"
      Rails.logger.error e.message
    end
    cache
  end

end
