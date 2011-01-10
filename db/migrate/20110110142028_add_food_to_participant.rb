class AddFoodToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :allergy_lactose, :boolean
    add_column :participants, :allergy_gluten, :boolean
    add_column :participants, :allergy_nuts, :boolean
    add_column :participants, :allergy_other, :string
    add_column :participants, :vegetarian, :boolean
  end

  def self.down
    remove_column :participants, :vegetarian
    remove_column :participants, :allergy_other
    remove_column :participants, :allergy_nuts
    remove_column :participants, :allergy_gluten
    remove_column :participants, :allergy_lactose
  end
end
