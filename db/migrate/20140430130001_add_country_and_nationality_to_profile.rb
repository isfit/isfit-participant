class AddCountryAndNationalityToProfile < ActiveRecord::Migration
  def up
    add_column :profiles, :country_id, :integer
    add_column :profiles, :citizenship_id, :integer
  end

  def down
    remove_column :profiles, :country_id
    remove_column :profiles, :citizenship_id
  end
end
