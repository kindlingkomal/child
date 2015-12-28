global = exports ? this

global.sign_up_ragpicker_js = ->
  $('.radio input').change ->
    if $('.radio .yrd').is(':checked')
      $('.form-group.yard').show 'slow'
    else
      $('.form-group.yard').hide 'slow'
      $('.form-group.yard input').val ''

  $('.radio input').trigger 'change'
