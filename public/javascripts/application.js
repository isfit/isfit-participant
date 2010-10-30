// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
    $(".select-date").datepicker({
      changeMonth: true,
      yearRange: "1920:2010",
      changeYear: true
      });
    $(".select-datetime").datepicker();
});
