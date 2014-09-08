module Applications::WorkshopHelper
  def financial_aid_form_tag
    if @workshop_application.applying_for_support
      '<div id="financial_aid_form">'.html_safe
    else
      '<div id="financial_aid_form" style="display: none;">'.html_safe
    end
  end
end
