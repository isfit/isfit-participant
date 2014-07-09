class RemoveFunctionaries < ActiveRecord::Migration
	def up
		drop_table :functionaries
	end

	def down
		create_table :functionaries do |t|
			t.integer :user_id

			t.timestamps
		end
	end
end
