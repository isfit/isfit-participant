class AddReviewFieldsToWorkshopApplication < ActiveRecord::Migration
  def change
    add_column :workshop_applications, :workshop_application_grade, :integer, after: :profile_grade
    add_column :workshop_applications, :workshop_application_reviewer_id, :integer, after: :workshop_application_grade

    add_index :workshop_applications, :workshop_application_reviewer_id
  end
end
