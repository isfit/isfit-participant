class RemoveEmailFromFunctionaries < ActiveRecord::Migration
  def up
    remove_column :functionaries, :email
  end

  def down
    add_column :functionaries, :email, :string
  end
end
