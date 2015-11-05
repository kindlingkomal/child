class TwilioService
  def self.send_reset_pwd(phone, pwd)
    message = "Your STV password: #{pwd}"
    phone = "+#{phone[2..-1]}" if phone.index('00') == 0
    opts = {from: '+12017305691', to: phone, body: message}
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_ID'], ENV['TWILIO_AUTH_TOKEN']
    rt = false
    begin
      data = client.messages.create(opts)
      rt = true
    rescue Exception => ex
      Rails.logger.error(ex.inspect)
      rt = false
    end

    return rt

  end
end
