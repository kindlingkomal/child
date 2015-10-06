require 'gcm'
class GcmService
  def initialize app_key, user
    @current_user = user
    @gcm = GCM.new(app_key)
  end

  def push_to_registration_ids(reg_ids, opts={})
    return false if reg_ids.blank? || opts[:collapse_key].blank?

    registration_ids= ["12", "13"] # an array of one or more client registration IDs
    options = {data: {score: "123"}, collapse_key: "updated_score"}
    response = gcm.send(registration_ids, options)
  end

end
