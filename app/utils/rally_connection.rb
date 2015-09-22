require 'rally_api'

# Establish connection with Rally.  Encapsulates all knowledge of configuring and communicating with Rally.
class RallyConnection

  def self.connect

    headers = RallyAPI::CustomHttpHeader.new()
    headers.name = "Demo Data Gen"
    headers.vendor = "Rally Software"
    headers.version = "1.0"

    config = {}
    config[:base_url] = Rails.configuration.rally.connect.base_url
    config[:username] = Rails.configuration.rally.connect.username
    config[:password] = Rails.configuration.rally.connect.password
    config[:headers]  = headers
    
    rally = RallyAPI::RallyRestJson.new(config)

    Rails.logger.info " > Connected to Rally: URL:#{config[:base_url]}"

    rally
  end
end
