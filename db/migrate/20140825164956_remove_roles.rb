class RemoveRoles < ActiveRecord::Migration
  def up
    drop_table :roles
  end

  def down
    create_table :roles do |t|
      t.string   :name,              :limit => 40
      t.string   :authorizable_type, :limit => 40
      t.integer  :authorizable_id
      
      t.timestamp
    end
  end
end
