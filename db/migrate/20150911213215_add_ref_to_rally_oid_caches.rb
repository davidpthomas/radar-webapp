class AddRefToRallyOidCaches < ActiveRecord::Migration
  def change
    add_column :rally_oid_caches, :ref, :string
  end
end
