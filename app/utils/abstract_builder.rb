# Base class for workspace builders containing common utility methods
class AbstractBuilder
  def initialize

    # creating a job provides a unique identifier for the build of all related artifacts
    job = Job.create(name: self.class.name)
    @job_id = job.id

    # 'loose' cache of artifacts for quick lookup; these haven't been created in rally yet; good for looking up names and looping
    @artifact_cache = {}
  end

  # dynamically queue jobs based on method being called that should match a Rally Artifact (e.g. workspace, project, release, etc)
  def method_missing(m, *args, &block)

    # queue the job by dynamically creating the instance based on missing method name
    rally_klass_name = m.to_s.camelize                # e.g. 'project' -> 'Project'
    rally_klass = Class.const_get(rally_klass_name)   # create instance of Project
    now(rally_klass, *args)                           # queue that instance as a job on the queue

    # cache instance requests for easy lookup later on
    cache_key = m.to_sym
    if !@artifact_cache.has_key?(cache_key)
      @artifact_cache[cache_key] = []
    end
    @artifact_cache[cache_key].push(args[0])        # only need first elem which is the hash artifact attrs  (e.g. name, project ,etc)
  end

  private

  # Register the job to be worked immediately; combine with job info
  def now(klass, attrs)

    attrs.merge!(job_id: @job_id)

    Resque.enqueue(klass, attrs)
    Rails.logger.debug("Queuing [now]: #{klass.to_s} #{attrs.inspect}")
  end
end


