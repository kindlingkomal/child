require 'gcm'
class GcmService
  def initialize user
    @current_user = user
    @gcm = GCM.new(ENV['GCM_SECRET_KEY'])#||'AIzaSyCDcjxhc_7sTLGC2u4oRUwvDxsgecyhjpk')
  end

  def push_to_registration_ids(reg_ids, opts={})
    Rails.logger.debug(reg_ids.inspect)
    return false if reg_ids.blank? || opts[:data].blank?
    reg_ids = reg_ids.compact.uniq
    return false if reg_ids.blank?
    options = opts.merge({
      # collapse_key: "demo",
      delay_while_idle: true,
      time_to_live: 100
    })
    Rails.logger.debug(options.inspect)
    response = @gcm.send(reg_ids, options)
    # Rails.logger.info(response)
    Rails.logger.info(response.inspect)
    response
  end


  def notify_new_pickup(pickup)
    options = {
      data: {
        key: 'pk.new',
        pk: {
          id: pickup.id,
          start_time: pickup.start_time.to_i,
          end_time: pickup.end_time.to_i,
          address: pickup.address
        },
        user: {
          id: pickup.user_id,
          name: pickup.user.full_name,
          gender: pickup.user.gender
        }
      },
      collapse_key: 'demo1',
    }
    reg_ids = User.ragpickers.where("gcm_registration IS NOT NULL").pluck('gcm_registration')
    push_to_registration_ids(reg_ids, options)
  end

  def accept_pickup(pickup)
    options = pickup_activity_data(pickup, 'accepted')
    reg_ids = []
    if @current_user.id == pickup.user_id
      user = pickup.ragpicker
      reg_ids = [user.gcm_registration] if user
    else
      user = pickup.user
      reg_ids = [user.gcm_registration]
    end
    push_to_registration_ids(reg_ids, options)
  end

  def cancel_pickup(pickup)
    options = pickup_activity_data(pickup, 'canceled')
    reg_ids = []
    if @current_user.id == pickup.user_id
      user = pickup.ragpicker
      reg_ids = [user.gcm_registration] if user
    else
      user = pickup.user
      reg_ids = [user.gcm_registration]
    end
    push_to_registration_ids(reg_ids, options)
  end

  def proceed_pickup(pickup)
    options = pickup_activity_data(pickup, 'proceeded')
    user = pickup.user
    reg_ids = [user.gcm_registration]
    push_to_registration_ids(reg_ids, options)
  end

private
  def pickup_activity_data(pickup, status)
    options = {
      data: {
        key: "pk.#{status}",
        pk: {
          id: pickup.id,
          start_time: pickup.start_time.to_i,
          end_time: pickup.end_time.to_i,
          address: pickup.address
        },
        user: {
          id: @current_user.id,
          name: @current_user.full_name,
        }
      },
      collapse_key: 'demo1',
    }
  end
end
