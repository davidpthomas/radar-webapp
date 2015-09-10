# Base class for workspace builders containing common utility methods
class AbstractBuilder
  def initialize
    job = Job.create(name: self.class.name)
    @job_id = job.id
  end

  def workspace(attrs)
    now(RallyWorkspace, attrs)
  end

  def project(attrs)
    now(RallyProject, attrs)
  end

  private

  # register the job to be worked immediately; combine with job info
  def now(klass, attrs)
    attrs.merge!(job_id: @job_id)
    Resque.enqueue(klass, attrs)
    Rails.logger.debug("[now] Queue: #{klass.to_s} #{attrs.inspect}")
  end
end


