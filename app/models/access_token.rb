require 'securerandom'

class AccessToken < ActiveRecord::Base
  class << self
    def generate
      create! token: SecureRandom.hex(124)
    end

    def use(token)
      find_by_token(token).delete
    end
  end
end
