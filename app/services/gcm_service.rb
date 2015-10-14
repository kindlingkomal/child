require 'gcm'
class GcmService
  def initialize user, app_key
    @current_user = user
    @gcm = GCM.new(app_key||'AIzaSyCDcjxhc_7sTLGC2u4oRUwvDxsgecyhjpk')
  end

  def push_to_registration_ids(reg_ids, opts={})
    return false if reg_ids.blank? || opts[:data].blank?
    reg_ids = [
      # 'e2K_J_kYVBo:APA91bEqaHkMW8M23UT23A_J4QzXJJP0-auUlKNtsF7wulKrnxIwxb1MFygV19d3fVwppLmMr2hyp7mNpgJY2s_IAmc6vBXQG4k_vdvTnhKW5fzwXus-kSPiQNPE_kMub1bsD-SJY7YC',
      'fgA_dT7hKKA:APA91bFlAzP6brJ9Gs8brMxnLZXnzzIqHWO2oguwza4DVVG8VHkQPWj0Ti0v6NnLN7RaLaLSLhzCPIhunxJvLGyOI5bbgMRNVQ_vLE0sHUfkF__3m4ctQO9IJLzvcQTkGFvIKftzLLpM'
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
      data: {id: pickup.id, key: 'pickup.new', msg: "hello"},
      collapse_key: 'demo1',
    }
    reg_ids = User.where("gcm_registration IS NOT NULL").pluck('gcm_registration')
    push_to_registration_ids(reg_ids, options)
  end


end
