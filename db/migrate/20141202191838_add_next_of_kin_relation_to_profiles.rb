class AddNextOfKinRelationToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :next_of_kin_relation, :string, after: :next_of_kin_address
  end
end
