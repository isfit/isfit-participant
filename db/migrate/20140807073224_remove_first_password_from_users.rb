class RemoveFirstPasswordFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :first_password
  end

  def down
    add_column :users, :first_password, :string, after: :avatar_updated_at
  end
end
