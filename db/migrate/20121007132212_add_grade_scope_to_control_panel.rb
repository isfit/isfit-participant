class AddGradeScopeToControlPanel < ActiveRecord::Migration
  def change
    add_column :control_panels, :app_grade2_scope, :integer
  end
end
