class AddQuestionsToDialogueApplication < ActiveRecord::Migration
  def change
    add_column :dialogue_applications, :ethnicity, :string, null: false, default: ''
    add_column :dialogue_applications, :national, :boolean, null: false, default: false
    add_column :dialogue_applications, :realtives, :boolean, null: false, default: false
  end
end
