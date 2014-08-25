class RemoveUserRoles < ActiveRecord::Migration
  def up
    drop_table :user_roles
  end

  def down
    create_table :user_roles do |t|
      t.integer  :user_id
      t.integer  :role_id

      t.timestamps
    end
  end
end
