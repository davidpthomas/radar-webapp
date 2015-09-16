require 'rally_oid_cache'

class RallyCacheManager

  def self.cache(job_id, type, name, oid, ref)
    cache_obj = { job_id: job_id, artifact_type: type, name: name, oid: oid, ref: ref } 
    begin
      cache = RallyOidCache.create(cache_obj) 
      Rails.logger.info "Cached: #{cache.inspect}"
    rescue Exception => e
      Rails.logger.error "Unable to cache #{cache_obj}"
    end
  end

  def self.find_by_name(job_id, name)
    query = { job_id: job_id, name: name}
    cache = RallyOidCache.find_by(query)
    Rails.logger.debug "FOUND in CACHE: #{cache.inspect}"
    cache
  end
end
