module WorkshopApplicationsHelper
  def total_grade (profile_grade, workshop_application_grade)
    return '-' if profile_grade.nil?
      
    total_grade = profile_grade
    total_grade += workshop_application_grade || 0
  end

  def get_gender (gender)
    case gender 
    when 0 then "Male"
    when 1 then "Female"
    when 2 then "Intersex"
    else "-"
    end
  end
end
