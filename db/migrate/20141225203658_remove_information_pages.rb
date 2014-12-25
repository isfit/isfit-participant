class RemoveInformationPages < ActiveRecord::Migration
  def up
    drop_table :information_categories
    drop_table :information_pages
  end

  def down
    create_table "information_categories" do |t|
      t.string "title"
    end
  
    create_table "information_pages" do |t|
      t.string   "title"
      t.text     "content"
      t.integer  "user_id"
      t.integer  "information_category_id"
      t.datetime "created_at",              :null => false
      t.datetime "updated_at",              :null => false
    end
  end
end
