class DropTableQuestionStatus < ActiveRecord::Migration
  def change
    drop_table :question_statuses
  end
end
