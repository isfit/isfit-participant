$(document).ready(function() {
  $('#workshop_application_applying_for_support').change(function(){
    if (this.checked) {
      $('#financial_aid_form').fadeIn('slow');
    }
    else {
      $('#financial_aid_form').fadeOut('slow');
    }
  });               
});