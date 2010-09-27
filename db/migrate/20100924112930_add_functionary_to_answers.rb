class AddFunctionaryToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :functionary_id, :int
  end

  def self.down
    remove_column :answers, :functionary_id
  end
end
