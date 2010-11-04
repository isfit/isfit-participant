class AddFirstPasswordToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_password, :string
  end

  def self.down
    remove_column :users, :first_password
  end
end
