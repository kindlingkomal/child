#= require active_admin/base

$(()->
  $('.admin_notifying_ragpickers .table_tools').html($('.notify_form'))
  $(".admin_notifying_ragpickers .paginated_collection table.index_table").tableCheckboxToggler()

  $(".datepicker2").datepicker
    minDate: new Date()
    dateFormat: "yy-mm-dd"

  $(".datepicker2").change ->
    $.get '/admin/pick_ups/time_slots.js?date=' + $(this).val()

  $('form#session_new input#admin_user_email').change ->
    $('form#session_new input#admin_user_password').val ''
)
