class AddPublishAtToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :publish_at, :datetime
  end

  def self.down
    remove_column :articles, :publish_at
  end
end
