class AddFunctionaryIdToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :functionary_id, :integer
  end

  def self.down
    remove_column :articles, :functionary_id
  end
end
