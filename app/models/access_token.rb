require 'securerandom'

class AccessToken < ActiveRecord::Base

  def use
    destroy
  end

  class << self
    def generate
      create! token: SecureRandom.hex(124)
    end
  end
end
