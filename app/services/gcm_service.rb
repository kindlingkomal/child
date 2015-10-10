require 'gcm'
class GcmService
  def initialize app_key, user
    @current_user = user
    @gcm = GCM.new(app_key)
  end

  def push_to_registration_ids(reg_ids, opts={})
    return false if reg_ids.blank? || opts[:collapse_key].blank?

    registration_ids= ["12", "13"] # an array of one or more client registration IDs
    options = {
      data: {score: "123"},
      collapse_key: "demo",
      delay_while_idle: true,
      time_to_live: 100
    }
    response = @gcm.send(registration_ids, options)
  end


  def notify_new_pickup(pickup)
    options = {
      data: {id: pickup.id},
      collapse_key: 'demo1',
    }
    reg_ids = User.where("gcm_registration IS NOT NULL").pluck('gcm_registration')
    push_to_registration_ids(reg_ids, options)
  end


end
