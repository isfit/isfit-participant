class ReorderAnswers < ActiveRecord::Migration
  def up
    change_table :answers do |t|
      t.change :question_id, :integer, after: :content, null: false

      t.change :created_at, :datetime, after: :user_id, null: false
      t.change :updated_at, :datetime, after: :user_id, null: false
      
      t.change :user_id, :integer, null: false
    end

    add_index :answers, :question_id
    add_index :answers, :user_id
  end

  def down
  end
end
