# Base class for workspace builders containing common utility methods
class AbstractBuilder
  def initialize
    job = Job.create(name: self.class.name)
    @job_id = job.id

    # cache artifacts for quick lookup
    @artifact_cache = {workspaces: [], projects: [], releases: []}
  end

  def workspace(attrs)
    now(RallyWorkspace, attrs)
    @artifact_cache[:workspaces].push(attrs)
  end

  def project(attrs)
    now(RallyProject, attrs)
    @artifact_cache[:projects].push(attrs)
  end

  def release(attrs)
    now(RallyRelease, attrs)
    @artifact_cache[:releases].push(attrs)
  end

  # TODO
  # - use method_missing to dynamically convert 'project' to now(RallyProject)

  private

  # register the job to be worked immediately; combine with job info
  def now(klass, attrs)
    attrs.merge!(job_id: @job_id)
    Resque.enqueue(klass, attrs)
    Rails.logger.debug("[now] Queue: #{klass.to_s} #{attrs.inspect}")
  end
end


