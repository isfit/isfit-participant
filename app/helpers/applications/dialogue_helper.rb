module Applications::DialogueHelper
  def selected_country
    if params[:country].nil? == false && params[:country][:country_id].present? == true
      return params[:country][:country_id]
    end
  else
  end
end
