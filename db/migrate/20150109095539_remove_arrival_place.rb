class RemoveArrivalPlace < ActiveRecord::Migration
  def up
    drop_table :arrival_places
  end

  def down
    create_table :arrival_places do |t|
      t.string :name
    end
  end
end
