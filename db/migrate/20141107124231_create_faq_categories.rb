class CreateFaqCategories < ActiveRecord::Migration
  def change
    create_table :faq_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
