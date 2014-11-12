class RemoveFieldsFromQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :dialogue
    remove_column :questions, :participant_id
    remove_column :questions, :question_id
  end

  def down
    add_column :questions, :dialogue, :integer
    add_column :questions, :participant_id, :integer
    add_column :questions, :question_id, :integer
  end
end
