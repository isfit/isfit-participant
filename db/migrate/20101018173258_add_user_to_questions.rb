class AddUserToQuestions < ActiveRecord::Migration
  def self.up 
    add_column :questions, :user_id, :int
  end

  def self.down
    remove_column :questions, :user_id
  end
end
