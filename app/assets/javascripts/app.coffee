global = exports ? this

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
    $('.list-nav > ul > li:nth-child(2)').addClass 'clrbk'
    $('.list-nav > ul > li:nth-child(2)>a').css 'color', '#fff'
    $('.tab-time').hide()
    $('.tab-sign').hide()

  $('.tab3').click ->
    $('.tab-add').hide()
    $('.tab-time').show()
    $('.list-nav > ul > li:nth-child(3)').addClass 'clrbk'
    $('.list-nav > ul > li:nth-child(3)>a').css 'color', '#fff'
    $('.tab-sign').hide()

  $('.devise-login-form').on 'submit', 'form.login2', ->
    path = $(this).closest('.devise-login-form').attr 'after_signin_path'
    $(this).append $('<input type="hidden" name="after_signin_path" />').val(path)
