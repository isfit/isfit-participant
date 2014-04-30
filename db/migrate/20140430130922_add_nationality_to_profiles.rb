class AddNationalityToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :nationality, :string
  end
end
