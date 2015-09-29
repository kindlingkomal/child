class MessagingService
  def self.client
    @gcm ||= GCM.new(ENV['GCM_API_KEY'])
  end

  def self.send(key, registration_ids, data)
    options = {collapse_key: key, data: data}
    # puts "====#{options.inspect}"
    client.send(registration_ids, options)
  end

  def self.with_pickup_created(pickup)
    key = 'create_pick_up'
    if (users = pickup.user.near_ragpickers).size > 0
      options = {key: key, sent_at: Time.zone.now}
      options = options.merge(pick_up: PickUpSerializer.new(pickup).attributes)
      users.each do |user|
        if (registration = user.gcm_registration).present?
          MessagingService.send(key, [registration], options)
        end
      end
    end
  end

end
