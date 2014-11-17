class AddOwnerToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :owner_id, :integer, after: :user_id
  end
end
