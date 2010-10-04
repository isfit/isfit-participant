class AddUserIdToFunctionary < ActiveRecord::Migration
  def self.up
    add_column :functionaries, :user_id, :integer
  end

  def self.down
    remove_column :functionaries, :user_id
  end
end
