require 'rally_api'
require 'rally_cache_manager'

class RallyWorker

  @queue = :rallyworker

  def self.perform(*attrs)
  #@queue = *args[0]['queue']
    # connect to Rally so worker has access
    self.connect
    self.work(*attrs)
  end

  protected

  def self.create(type, attrs)
    type_s = type.to_s
    begin
      # create object
      obj = @rally.create(type_s, attrs)
Rails.logger.info "HERE1"
      # cache oid results
      RallyCacheManager.cache(attrs['job_id'], type_s, obj.name, obj.ObjectID)
Rails.logger.info "HERE2"

      Rails.logger.info " >> created '#{type_s}' with attrs #{attrs.inspect}"
    rescue Exception => e
Rails.logger.info "HERE3 #{e.inspect}"
      Rails.logger.error "ERROR: Creating #{type} with args #{args.inspect}"
    end

  end

  private

  def self.connect

    headers = RallyAPI::CustomHttpHeader.new()
    headers.name = "Data Gen"
    headers.vendor = "Rally Software"
    headers.version = "1.0"

    config = {:base_url => "https://demo-emea.rallydev.com/slm"}
    config[:username]   = "paul@acme.com"
    config[:password]   = "RallyON!"
#    config[:workspace]  = "Integrations"
#    config[:project]    = "Shopping Team"
    config[:headers]    = headers

    @rally = RallyAPI::RallyRestJson.new(config)

    Rails.logger.info " > Connected to Rally: URL:#{config[:base_url]} - WS:#{config[:workspace]} - PRJ:#{config[:project]}"

  end

end
