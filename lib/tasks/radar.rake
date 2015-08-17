namespace :radar do

  task :setup => :environment do
  end

  desc "Build a new workspace with unique #"
  task :build_workspace => :setup do
    WorkspaceBuilderFactory.build(:online_store)
  end
end
