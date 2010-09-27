class AddContentToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :content, :text
  end

  def self.down
    remove_column :answers, :content
  end
end
