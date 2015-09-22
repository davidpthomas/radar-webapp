class CreateRallyEnumCaches < ActiveRecord::Migration
  def change
    create_table :rally_enum_caches do |t|
      t.string :artifact_type
      t.string :name
      t.string :value

      t.timestamps null: false
    end
  end
end
