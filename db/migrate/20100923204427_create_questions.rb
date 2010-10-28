class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :subject
      t.text :content
      t.integer :dialogue
      t.integer :participant_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
