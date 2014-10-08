module Applications::DialogueHelper
  def selected_country
    if params[:country].nil? == false && params[:country][:country_id].present? == true
      return params[:country][:country_id]
    end
  end
  def isLateApplicant(dialogue_application)
    if dialogue_application.user.created_at > DateTime.new(2014, 10, 7, 1, 0, 0, '+02:00')
      return 'Yes'
    else
      return 'No'
    end
  end
end
