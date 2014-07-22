class ChangePhoneColumnInProfile < ActiveRecord::Migration
  def up
    change_column :profiles, :phone, :string, limit: 30
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
