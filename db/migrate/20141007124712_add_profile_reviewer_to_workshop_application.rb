class AddProfileReviewerToWorkshopApplication < ActiveRecord::Migration
  def change
    add_column :workshop_applications, :profile_reviewer_id, :integer, after: :still_attend
    add_index :workshop_applications, :profile_reviewer_id
  end
end
