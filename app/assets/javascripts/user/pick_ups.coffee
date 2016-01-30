PickUpsController = Paloma.controller('User/PickUps')

PickUpsController::new = PickUpsController::create = ->
  new_pick_up_js()

PickUpsController::manage = ->
  manage_pick_ups_js()

PickUpsController::reschedule = PickUpsController::book = ->
  reschedule_pick_up_js()
