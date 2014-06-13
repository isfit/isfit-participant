class CreateDialogueApplications < ActiveRecord::Migration
  def change
    create_table :dialogue_applications do |t|
      t.integer :relationship_status, null: false
      t.integer :english_proficiency, null: false
      t.integer :french_proficiency, null: false
      t.text :dialogue_essay, null: false, default: ''
      t.text :conflict_essay, null: false, default: ''
      t.text :vision_essay, null: false, default: ''
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
