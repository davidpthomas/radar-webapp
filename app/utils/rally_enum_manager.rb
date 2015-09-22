require 'rally_connection'

class RallyEnumManager

  def self.find_by_name(type, name)
    query = { artifact_type: type, name: name}
    # look in db cache first
    cache = RallyEnumCache.find_by(query)
    Rails.logger.info "GOT ENUM CACHE: #{cache.inspect}"
    # not cached locally, go fetch from rally
    if cache.nil?
      Rails.logger.info "Local ENUM Cache empty."
      cache = self.lookup(type, name)
    end
    cache.name
  end

  private

  def self.lookup(type, name)

    rally = RallyConnection.connect

    query = RallyAPI::RallyQuery.new()
    query.type = type
    query.query_string = "(Name = \"#{name}\" )"
    query.fetch = "Name,Value"

    Rails.logger.info "Rally Lookup: #{type} - #{name}"
    results = rally.find(query)
    
    result = results.first
    self.cache(type, result.name, result.Value)
    result
  end

  def self.cache(type, name, value)
    cache_obj = { artifact_type: type, name: name, value: value } 
    begin
      cache = RallyEnumCache.create(cache_obj) 
      Rails.logger.info "Cached: [type|#{cache.artifact_type}] - [name|#{cache.name}] - [value|#{cache.value}]"
    rescue Exception => e
      Rails.logger.error "Unable to cache #{cache_obj}"
      Rails.logger.error e.message
    end
  end

end
