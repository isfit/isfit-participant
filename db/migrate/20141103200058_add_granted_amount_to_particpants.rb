class AddGrantedAmountToParticpants < ActiveRecord::Migration
  def change
    add_column :participants, :granted_amount, :integer, limit: 2
  end
end
