require 'gcm'
class GcmService
  def initialize app_key, user
    @current_user = user
    @gcm = GCM.new(app_key||'AIzaSyDWn6_GofSOKvMSG7lWyOhgwYLHzQ4J0m0')
  end

  def push_to_registration_ids(reg_ids, opts={})
    return false if reg_ids.blank? || opts[:data].blank?
    reg_ids = [
      "ev-pmPVXrjY%3AAPA91bErCTNKHn8lt3DjdGFfVNAKXBlRZtGL8VIBoQCvUuZZzf77byEojgfd3zC0GA8pGaO2tnG0X9obUHi0eFNXcaA6WhwWq8Qx4T58S-RlmzLgXY7KWx54cdbuvVoXB8rWNb3-Exf5",
      "caOIEJuzQQ8:APA91bGgtd86DT3WfIqHBk_4Xlns5aVPg9TLXKzaeMxPaPlL_Qz_WK9xMUrr1hfQxC_hmDSvm6AFxs7XlQRZL5sc5iOQc35VC-UyfbMLQa8ciQtLg_f-gbPQNx2Mq9xsB0cUMDy4nmEb"
    ]
    options = opts.merge({
      collapse_key: "demo",
      delay_while_idle: true,
      time_to_live: 100
    })
    response = @gcm.send(reg_ids, options)
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
