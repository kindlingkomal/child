#= require active_admin/base

$(()->
  $('.admin_notifying_ragpickers .table_tools').html($('.notify_form'))
  $(".admin_notifying_ragpickers .paginated_collection table.index_table").tableCheckboxToggler()
)
