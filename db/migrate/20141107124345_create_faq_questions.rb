class CreateFaqQuestions < ActiveRecord::Migration
  def change
    create_table :faq_questions do |t|
      t.string :question
      t.text :answer
      t.integer :category_id

      t.timestamps
    end

    add_index :faq_questions, :category_id
  end
end
