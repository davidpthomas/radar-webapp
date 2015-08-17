require "resque/tasks"
require "resque/scheduler/tasks"

namespace :resque do
  task :setup do
    require 'resque'

    Resque.redis = "#{ENV['RADARWEBAPP_REDIS_1_PORT_6379_TCP_ADDR']}:#{ENV['RADARWEBAPP_REDIS_1_PORT_6379_TCP_PORT']}"
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'
  end

  task :scheduler => :setup_schedule

end

task "resque:setup" => :environment


