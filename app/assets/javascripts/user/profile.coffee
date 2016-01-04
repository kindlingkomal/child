ProfileController = Paloma.controller('User/Profile')

ProfileController::edit = ProfileController::update = ->
  $('img.choose_user_avatar').click ->
    $('#user_avatar[type=file]').trigger('click')
