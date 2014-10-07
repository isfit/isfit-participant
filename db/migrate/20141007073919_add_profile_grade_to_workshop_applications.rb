class AddProfileGradeToWorkshopApplications < ActiveRecord::Migration
  def change
    add_column :workshop_applications, :profile_grade, :integer, null: true, after: :still_attend
  end
end
