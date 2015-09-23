require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

	test "valid job" do
		job = Job.new(name: 'test job')
		assert job.save, "Unable to save valid job."
	end	

	test "name required" do
		job = Job.new(name: nil)
		assert_not job.save, "Created the job without a name."
	end	

end
