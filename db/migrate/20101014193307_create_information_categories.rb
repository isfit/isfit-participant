class CreateInformationCategories < ActiveRecord::Migration
  def self.up
    create_table :information_categories do |t|
      t.string :title
    end
  end

  def self.down
    drop_table :information_categories
  end
end
