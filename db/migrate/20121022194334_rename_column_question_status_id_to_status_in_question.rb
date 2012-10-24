class RenameColumnQuestionStatusIdToStatusInQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :question_status_id, :status
  end
end
