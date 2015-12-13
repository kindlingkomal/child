CategoriesController = Paloma.controller('Categories')

CategoriesController::index = ->
  $('input.check_boxes').change ->
    checked_count = $('input:checked').length
    $('.num_categories_selected').html('(' + checked_count + ')')
    if $(this).is(':checked')
      $(this).closest('.checkbox.category').removeClass('unchecked').addClass 'checked'
    else
      $(this).closest('.checkbox.category').removeClass('checked').addClass 'unchecked'
