class CreateInformationPages < ActiveRecord::Migration
  def self.up
    create_table :information_pages do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :information_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :information_pages
  end
end
