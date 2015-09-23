class AddRefToRallyEnumCache < ActiveRecord::Migration
  def change
    add_column :rally_enum_caches, :ref, :string
  end
end
