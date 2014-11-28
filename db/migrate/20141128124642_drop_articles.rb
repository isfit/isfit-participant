class DropArticles < ActiveRecord::Migration
  def up
    drop_table :articles
  end

  def down
    create_table :articles do |t|
      t.string   :title
      t.text     :content
      t.datetime :created_at,     null: false
      t.datetime :updated_at,     null: false
      t.integer  :functionary_id
      t.datetime :publish_at
      t.integer  :user_id
      t.integer  :sticky
    end
  end
end
