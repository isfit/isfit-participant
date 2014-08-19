class ChangeDialogueApplicationsDatatype < ActiveRecord::Migration
  def up
    change_column :dialogue_applications, :realtives, :string, default: nil
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
