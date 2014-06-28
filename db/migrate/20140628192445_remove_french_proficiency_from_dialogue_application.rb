class RemoveFrenchProficiencyFromDialogueApplication < ActiveRecord::Migration
  def up
  	remove_column :dialogue_applications, :french_proficiency
  end

  def down
  	add_column :dialogue_applications, :french_proficiency, :integer, null: false, default: 0
  end
end
