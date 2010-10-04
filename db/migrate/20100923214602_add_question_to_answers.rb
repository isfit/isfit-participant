class AddQuestionToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :question_id, :int
  end

  def self.down
    remove_column :answers, :question_id
  end
end
