class RemoveNameColumnsFromParticipants < ActiveRecord::Migration
  def up
    remove_column :participants, :first_name
    remove_column :participants, :last_name
    remove_column :participants, :email
  end

  def down
    add_column :participants, :first_name, :string
    add_column :participants, :last_name, :string
    add_column :participants, :email, :string
  end
end
