class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.belongs_to :region
      t.string :code, :limit => 4

      t.timestamps
    end
  end
end
