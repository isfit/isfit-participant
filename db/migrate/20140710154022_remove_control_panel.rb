class RemoveControlPanel < ActiveRecord::Migration
  def up
  	drop_table :control_panels
  end

  def down
  	create_table :control_panels do |t|
  	  t.boolean  :app_grade1,       default: false
  	  t.boolean  :app_grade2,       default: false
  	  t.boolean  :app_grade3,       default: false
  	  t.datetime :created_at,                          null: false
  	  t.datetime :updated_at,                          null: false
  	  t.integer  :app_grade2_scope
  	end
  end
end
