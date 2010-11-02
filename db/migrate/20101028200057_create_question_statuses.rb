class CreateQuestionStatuses < ActiveRecord::Migration
  def self.up
    create_table :question_statuses do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :question_statuses
  end
end
