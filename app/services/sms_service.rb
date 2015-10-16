require 'rest-client'
class SmsService

  def self.send(to, message)
    raw = RestClient.post ENV['SMS_API_URL'], to: to, message: message
    JSON.parse raw
  end

  def self.status(json)
    json['data'].nil? ? false : json['data']['0']['status'] == 'AWAITED-DLR'
  end

  def self.send_otp(to, otp)
    message = "Your STV password: #{otp}"
    sms = send(to, message)
    status(sms)
  end

end
