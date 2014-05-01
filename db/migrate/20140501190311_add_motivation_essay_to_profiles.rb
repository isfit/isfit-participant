class AddMotivationEssayToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :motivation_essay, :text, null: false, default: ''
  end
end
