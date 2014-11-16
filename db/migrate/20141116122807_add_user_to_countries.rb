class AddUserToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :user_id, :integer
    add_index :countries, :user_id
  end
end
