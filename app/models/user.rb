require 'bcrypt'

class User < ActiveRecord::Base

  validates_uniqueness_of :email

  validates_presence_of :email
  validates_presence_of :password, :on => :create

  validate :valid_token

  validates :password, length: { minimum: 8 }, confirmation: true

  before_save :encrypt_password

  attr_accessor :password, :password_confirmation, :token

  def authenticate(password)
    password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
    password_hash == self.password_hash
  end

  def valid_token
    if access_token = AccessToken.find_by(:token => token)
      access_token.use
    else
      errors.add(:token, "Token is not found")
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
