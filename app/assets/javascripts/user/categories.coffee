CategoriesController = Paloma.controller('Categories')

CategoriesController::index = ->
  $('input.check_boxes').change ->
    checked_count = $('input:checked').length
    $('.num_categories_selected').html('(' + checked_count + ')')
    if $(this).is(':checked')
      $(this).closest('.checkbox.category').removeClass('unchecked').addClass 'checked'
    else
      $(this).closest('.checkbox.category').removeClass('checked').addClass 'unchecked'

  $('.rate-card-continue').click ->
    if $('input[name="category_ids[]"]:checked').length > 0
      location.href = $(this).attr('data-url') + '?' + $('input[name="category_ids[]"]').serialize()
    else
      alert 'Please select categories'

  $('input.check_boxes:checked').trigger('change')

  $('.pickup_summary').click (e)->
    if $('input[name="category_ids[]"]:checked').length > 0
      e.preventDefault()
      location.href = $(this).attr('href') + '?' + $('input[name="category_ids[]"]').serialize()
