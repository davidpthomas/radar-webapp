require 'rally_api'
require 'rally_cache_manager'
require 'rally_connection'


class Worker

  def self.perform(*attrs)
    @job_id = attrs[0]['job_id']
    self.work(*attrs)
  end

  protected

  def self.create(type, attrs)
    begin
      Rails.logger.info" Creating '#{type}'"
      # create object
      rally = RallyConnection.connect
      obj = rally.create(type, attrs)
      # cache oid results
      RallyCacheManager.cache(attrs['job_id'], type, obj.Name, obj.ObjectID, obj.ref)

      Rails.logger.info " >> created '#{type}' with attrs #{attrs}"
    rescue Exception => e
      Rails.logger.error "Unable to create '#{type}' with attrs #{attrs.inspect}"
      Rails.logger.error e.message
    end
    obj
  end

end
