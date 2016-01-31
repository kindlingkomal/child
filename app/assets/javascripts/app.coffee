global = exports ? this

global.toggle_sign_up_in_form_for_user_js = ->
  $('#user_avatar[type=file]').change ->
    updateImagePreview($('#user_avatar[type=file]'), $('img.choose_user_avatar'))
  $('img.choose_user_avatar').click ->
    $('#user_avatar[type=file]').trigger('click')

  $('input.phone_number').mask('+910000000000', {'translation': {9: {pattern: /9/, fallback: '9'}}})
  $('.devise-new-password-form').hide()
  $(".signup2").hide()
  $(".sign").click ->
    $(".login2").hide 'slow'
    $(".signup2").show 'slow'
    $('.devise-new-password-form').hide()

  $(".log").click ->
    $(".login2").show 'slow'
    $(".signup2").hide 'slow'
    $('.devise-new-password-form').hide()

  $('.login2 input#user_phone_number').change ->
    $('.login2 input#user_password').val ''

  $('.forget-password-link').click ->
    $(".login2").hide 'slow'
    $(".signup2").hide 'slow'
    $('.devise-new-password-form').show 'slow'
    $('.modal-footer .signup2').show 'slow'

global.sign_up_ragpicker_js = ->
  $('.radio input').change ->
    if $('.radio .yrd').is(':checked')
      $('.form-group.yard').show 'slow'
    else
      $('.form-group.yard').hide 'slow'
      $('.form-group.yard input').val ''

  $('.radio input').trigger 'change'

global.new_pick_up_js = ->
  todayDate = new Date()
  initSlider todayDate
  $('input.phone_number').mask('+910000000000', {'translation': {9: {pattern: /9/, fallback: '9'}}})

  $('.tab-sign .login').hide()
  if $('.tab-sign').length > 0
    $('.tab-add').hide()

  $('.tab-time').hide()
  $('.login2').hide()

  $('a.login-a').click ->
    $('.signup2').hide 'slow'
    $('.login2').show 'slow'

  $('a.signup-a').click ->
    $('.signup2').show 'slow'
    $('.login2').hide 'slow'

  $('.tab2').click ->
    $('.tab-add').show()
    $('.list-nav > ul > li:nth-child(1)').addClass 'clrbk'
    $('.list-nav > ul > li:nth-child(1)>a').css 'color', '#fff'
    $('.tab-time').hide()
    $('.tab-sign').hide()

  $('.tab3').click ->
    $('.tab-add').hide()
    $('.tab-time').show()
    $('.list-nav > ul > li:nth-child(2)').addClass 'clrbk'
    $('.list-nav > ul > li:nth-child(2)>a').css 'color', '#fff'
    $('.tab-sign').hide()

  $('.devise-login-form').on 'submit', 'form.login2', ->
    path = $(this).closest('.devise-login-form').attr 'after_signin_path'
    $(this).append $('<input type="hidden" name="after_signin_path" />').val(path)

global.reschedule_pick_up_js = ->
  todayDate = new Date()
  initSlider todayDate

global.manage_pick_ups_js = ->
  $('.show-more').hide()
  $('.show-more-h').hide()
  $('.his-con').hide()
  $('.more').click ->
    $('.' + $(this).attr('data-more')).toggle 'slow'
    $(this).text (i, v) ->
      if v == 'MORE' then 'LESS' else 'MORE'

  $('.more-h').click ->
    $('.' + $(this).attr('data-more')).toggle 'slow'
    $(this).text (i, v) ->
      if v == 'More' then 'LESS' else 'More'

  $('.history').click ->
    $('.up-con').hide 'slow'
    $('.upcoming').removeClass 'active1'
    $('.his-con').show 'slow'
    $('.history').addClass 'active1'

  $('.upcoming').click ->
    $('.up-con').show 'slow'
    $('.history').removeClass 'active1'
    $('.upcoming').addClass 'active1'
    $('.his-con').hide 'slow'

global.updateImagePreview = (fileElement, previewElement) ->
  fileReader = new FileReader()
  files = fileElement[0].files
  if files
    fileReader.onload = (event) ->
      previewElement.attr 'src', event.target.result

    fileReader.readAsDataURL files[0]
