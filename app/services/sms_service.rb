class SmsService

  def self.send(to, message)
    raw = RestClient.post ENV['SMS_API_URL'], to: to, message: message
    Rails.logger.info(raw.inspect)
    JSON.parse raw
  end

  def self.status(json)
    json['data'].nil? ? false : json['data']['0']['status'] == 'AWAITED-DLR'
  end

  def self.send_reset_pwd(phone, pwd)
    send_message(phone, "Your STV password: #{pwd}")
  end

  def self.send_otp(phone, otp)
    send_message(phone, "Your OTP from STV: #{otp}")
  end

  def self.send_message(phone, message)
    phone = "+#{phone[2..-1]}" if phone.index('00') == 0
    rt = false
    begin
      data = send(phone, message)
      rt = status(data)
    rescue Exception => ex
      Rails.logger.error(ex.inspect)
      rt = false
    end

    return rt
  end

end
