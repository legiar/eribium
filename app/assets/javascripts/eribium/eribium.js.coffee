#= require jquery_ujs
#= require jquery_nested_form
#= require bootstrap
#= require bootstrap-datepicker
#= require select2
#= require jquery.noty

jQuery ->
  $.noty.defaults.layout = "topRight"

  $(".datepicker").datepicker
    format: "yyyy-mm-dd",
    weekStart: 1,
    autoclose: true
  $(document).delegate '.datepicker + button', 'click', (event) ->
    $(this).parent().find('.datepicker').datepicker('show')

  #$("select.select").select2
  #  width: "element"

  #$(document).delegate '.btn-file', 'click', (event) ->
  #  $(this).find("input[type=file]").click()


