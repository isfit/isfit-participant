module Review::WorkshopApplicationsHelper
  def review_stats
    applications = WorkshopApplication.valid.passed_profile_review

    {
      all: applications.count,
      graded: applications.wa_reviewed.count,
    }
  end

  def review_percentage
    ((review_stats[:graded].to_f / review_stats[:all].to_f)*100).to_i
  end
end
