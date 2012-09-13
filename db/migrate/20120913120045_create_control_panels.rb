class CreateControlPanels < ActiveRecord::Migration
  def change
    create_table :control_panels do |t|
      t.boolean :app_grade1, :default => false
      t.boolean :app_grade2, :default => false
      t.boolean :app_grade3, :default => false

      t.timestamps
    end
  end
end
