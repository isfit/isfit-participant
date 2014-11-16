class RemoveRegions < ActiveRecord::Migration
  def up
    drop_table :regions
    remove_column :countries, :region_id
  end

  def down
    create_table :regions do |t|
      t.string :name
    end

    add_column :countries, :region_id, :integer
  end
end
