class CreateRallyOidCaches < ActiveRecord::Migration
  def change
    create_table :rally_oid_caches do |t|
      t.integer :oid
      t.string :name
      t.string :artifact_type
      t.references :job, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
