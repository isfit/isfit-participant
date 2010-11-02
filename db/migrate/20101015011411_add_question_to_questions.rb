class AddQuestionToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_id, :int
  end

  def self.down
    remove_column :questions, :question_id
  end
end
