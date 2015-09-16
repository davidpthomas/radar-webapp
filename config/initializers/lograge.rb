
RadarWebapp::Application.configure do
  config.lograge.enabled = true
# create another log to single line for easier debugging
  config.lograge.keep_original_rails_log = true
  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
end
