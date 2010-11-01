class AddStickyToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :sticky, :integer
  end

  def self.down
    remove_column :articles, :sticky
  end
end
