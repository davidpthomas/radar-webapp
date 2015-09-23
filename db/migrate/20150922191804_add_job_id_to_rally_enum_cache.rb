class AddJobIdToRallyEnumCache < ActiveRecord::Migration
  def change
    add_column :rally_enum_caches, :job_id, :integer
  end
end
