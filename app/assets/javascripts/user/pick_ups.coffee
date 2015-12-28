PickUpsController = Paloma.controller('User/PickUps')

PickUpsController::new = ->
  todayDate = new Date()
  initSlider todayDate

  $('.tab-sign .login').hide()
  $('.tab-add').hide()
  $('.tab-time').hide()

  $('.log').click ->
    $('.signin').hide 'slow'
    $('.login').show 'slow'

  $('.sign').click ->
    $('.signin').show 'slow'
    $('.login').hide 'slow'

  $('.tab2').click ->
    $('.tab-add').show()
    $('.list-nav > ul > li:nth-child(2)').addClass 'clrbk'
    $('.list-nav > ul > li:nth-child(2)>a').css 'color', '#fff'
    $('.tab-time').hide()
    $('.tab-time').hide()
    $('.tab-sign').hide()

  $('.tab3').click ->
    $('.tab-add').hide()
    $('.tab-time').show()
    $('.list-nav > ul > li:nth-child(3)').addClass 'clrbk'
    $('.list-nav > ul > li:nth-child(3)>a').css 'color', '#fff'
    $('.tab-sign').hide()
