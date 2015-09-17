require 'rally_api'
require 'rally_cache_manager'

class Worker

  @queue = :rallyworker

  def self.perform(*attrs)
  #@queue = *args[0]['queue']
    # connect to Rally so worker has access
    self.connect
    self.work(*attrs)
  end

  protected

  def self.create(type, attrs)
    begin
      # create object
      obj = @rally.create(type, attrs)
      # cache oid results
      RallyCacheManager.cache(attrs['job_id'], type, obj.Name, obj.ObjectID, obj.ref)

      Rails.logger.info " >> created '#{type}' with attrs #{obj.Name}"
    rescue Exception => e
      Rails.logger.error "Unable to create '#{type}' with attrs #{attrs.inspect}"
      Rails.logger.error e.message
    end
    obj
  end

  private

  def self.connect

    headers = RallyAPI::CustomHttpHeader.new()
    headers.name = "Data Gen"
    headers.vendor = "Rally Software"
    headers.version = "1.0"

    config = {:base_url => "https://ec2-54-187-192-99.us-west-2.compute.amazonaws.com/slm"}
    config[:username]   = "paul@acme.com"
    config[:password]   = "RallyON!"
    config[:headers]    = headers

    @rally = RallyAPI::RallyRestJson.new(config)

    Rails.logger.info " > Connected to Rally: URL:#{config[:base_url]}"

  end

end
