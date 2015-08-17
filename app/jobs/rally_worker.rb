require 'rally_api'

class RallyWorker

  @queue = :rallyworker

  def self.perform(*args)
  #@queue = *args[0]['queue']
    self.connect
    self.work(*args)
  end

  private

  def self.connect

    headers = RallyAPI::CustomHttpHeader.new()
    headers.name = "Data Gen"
    headers.vendor = "Rally Software"
    headers.version = "1.0"

    config = {:base_url => "https://demo-rally.rallydev.com/slm"}
    config[:username]   = "paul@acme.com"
    config[:password]   = "RallyON!"
#    config[:workspace]  = "Integrations"
#    config[:project]    = "Shopping Team"
    config[:headers]    = headers

    @rally = RallyAPI::RallyRestJson.new(config)

    Rails.logger.info " > Connected to Rally: URL:#{config[:base_url]} - WS:#{config[:workspace]} - PRJ:#{config[:project]}"

  end

end
