class AddUserToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :user_id, :integer, null: false, after: :status
    add_index :questions, :user_id
  end
end
