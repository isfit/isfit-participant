class RemoveNamesFromFunctionaries < ActiveRecord::Migration
  def up
    remove_column :functionaries, :first_name
    remove_column :functionaries, :last_name
  end

  def down
    add_column :functionaries, :first_name, :string
    add_column :functionaries, :last_name, :string
  end
end
