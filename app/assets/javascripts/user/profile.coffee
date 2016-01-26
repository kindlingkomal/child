ProfileController = Paloma.controller('User/Profile')

ProfileController::edit = ProfileController::update = ->
  $('#user_avatar[type=file]').change ->
    updateImagePreview($('#user_avatar[type=file]'), $('img.choose_user_avatar'))

  $('img.choose_user_avatar').click ->
    $('#user_avatar[type=file]').trigger('click')
