class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.string :lead
      t.text :description

      t.timestamps
    end
  end
end
