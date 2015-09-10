require 'rally_oid_cache'

class RallyCacheManager

  def self.cache(job_id, type, name, oid)
    RallyOidCache.create(job_id: job_id, artifact_type: type, name: name, oid: oid) 
    Rails.logger.info "Cached Oid: #{type} - #{oid}"
  end
end
