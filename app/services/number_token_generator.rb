# Deprecate: Copied verbatim from Rails source, remove once we move to Rails 4 only.
require 'thread_safe'
require 'openssl'
require 'securerandom'

class NumberTokenGenerator
  def self.instance
    @number_token_generator ||= NumberTokenGenerator.new(
      Devise::CachingKeyGenerator.new(Devise::KeyGenerator.new(Devise.secret_key))
    )
  end

  def initialize(key_generator, digest="SHA256")
    @key_generator = key_generator
    @digest = digest
  end

  def digest(klass, column, value)
    value.present? && OpenSSL::HMAC.hexdigest(@digest, key_for(column), value.to_s)
  end

  def generate(klass, column)
    key = key_for(column)

    loop do
      raw = random_code
      enc = OpenSSL::HMAC.hexdigest(@digest, key, raw)
      break [raw, enc] unless klass.to_adapter.find_first({ column => enc })
    end
  end

  def generate_unique_code(klass, column)
    loop do
      raw = random_code
      break raw unless klass.to_adapter.find_first({ column => raw })
    end
  end

  def random_code
    SecureRandom.random_number(10000).to_s.rjust(4, '0')
  end

  private

  def key_for(column)
    @key_generator.generate_key("code #{column}")
  end
end
