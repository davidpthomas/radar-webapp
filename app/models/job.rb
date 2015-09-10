class Job < ActiveRecord::Base
	has_many :rally_oid_caches, dependent: :destroy	
end
