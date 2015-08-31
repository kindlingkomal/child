module TokenAuthenticatable
  extend ActiveSupport::Concern

  # Public: Checks that the object has an authentication token, and creates one
  # if not.
  #
  # Returns the authentication token for the object.
  def ensure_authentication_token!
    if authentication_token.blank?
      update(authentication_token: generate_authentication_token)
    end
    authentication_token
  end

  # Public: Assign a new, unique auth token, but do not save
  #
  # Returns new token
  def invalidate_authentication_token
    generate_authentication_token.tap do |token|
      self.authentication_token = token
    end
  end

  # Public: Remove the authentication token and save
  #
  # Returns the true or false value: did it save successfully?
  def invalidate_authentication_token!
    invalidate_authentication_token
    save
  end

  # Internal: Generates a unique authentication token for the class.
  #
  # Returns a unique authentication token.
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.where(authentication_token: token).exists?
    end
  end
end
