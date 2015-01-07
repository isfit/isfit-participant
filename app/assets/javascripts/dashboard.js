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

$(document).ready(function() {
  $("[name=participant\\[arrival_in_norway\\]]").click(function(){
    $('.toHide').hide();
    $('.toHideTransfer').hide();
    if ($(this).val() == 1) {
      $("#arrival-trd").show('fast');
    }
    $("#arrival-"+$(this).val()).show('fast');
  });
});

$(document).ready(function() {
  $("[name=participant\\[transfer_to_trd\\]]").click(function(){
    $('.toHideTransfer').hide();
    if ($(this).val() == 1) {
      $("#arrival-trd").show('fast');
    }
    if ($(this).val() == 2) {
      $("#arrival-3").show('fast');
    }
    if ($(this).val() == 3) {
      $("#transfer-train").show('fast');
    }
    $("#transfer-"+$(this).val()).show('fast');
  });
});

$(document).ready(function() {
  $("[name=participant\\[departure_trd\\]]").click(function(){
    $('.toHideDepTrd').hide();
    $("#deptrd-"+$(this).val()).show('fast');
  });
});

$(document).ready(function() {
  $("[name=participant\\[departure_norway\\]]").click(function(){
    $('.toHideDepNor').hide();
    $("#depnor-"+$(this).val()).show('fast');
  });
});