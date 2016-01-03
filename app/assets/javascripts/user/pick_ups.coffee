PickUpsController = Paloma.controller('User/PickUps')

PickUpsController::new = PickUpsController::create = ->
  new_pick_up_js()

PickUpsController::manage = ->
  manage_pick_ups_js()

PickUpsController::reschedule = ->
  reschedule_pick_up_js()
