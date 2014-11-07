class AddQuestionsCountToCategories < ActiveRecord::Migration
  def change
    add_column :faq_categories, :questions_count, :integer, default: 0
  end
end
