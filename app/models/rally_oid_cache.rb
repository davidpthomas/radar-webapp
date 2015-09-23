class RallyOidCache < ActiveRecord::Base
  belongs_to :job
	validates_associated :jobs
 validates :job, presence: true
end
