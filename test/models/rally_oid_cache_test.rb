require 'test_helper'

class RallyOidCacheTest < ActiveSupport::TestCase

	def setup
		@workspace = rally_oid_caches(:workspace)
		@project = rally_oid_caches(:project)
	end

	def teardown
	end

  test "the truth" do
    assert true
  end

	test "fixture data exists" do
		assert @workspace[:oid], "Workspace fixture not found."
		assert @project[:oid], "Project fixture not found."
	end

end
