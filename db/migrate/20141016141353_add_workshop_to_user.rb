class AddWorkshopToUser < ActiveRecord::Migration
  def change
    add_column :users, :workshop_id, :integer

    add_index :users, :workshop_id
  end
end
