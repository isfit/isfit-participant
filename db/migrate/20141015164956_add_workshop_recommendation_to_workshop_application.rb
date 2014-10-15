class AddWorkshopRecommendationToWorkshopApplication < ActiveRecord::Migration
  def change
    add_column :workshop_applications, :workshop_recommendation_id, :integer, after: :workshop_application_grade

    add_index :workshop_applications, :workshop_recommendation_id
  end
end
