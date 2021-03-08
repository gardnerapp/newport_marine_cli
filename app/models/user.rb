class User < ApplicationRecord
  attr_accessor :remember_token
  has_one :boat, dependent: :destroy
  has_many :appointments, dependent: :destroy
  before_save { email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                    uniqueness: {case_sensitive: false}
  validates :phone, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: {minimum: 6}
  # 1. saves password digest attribute to db
  # 2. adds password and confirmation presence and equal validations
  # 3. the auth method returns user if pWord is correct
  has_secure_password

  # TODO test this stuff below
  # Remembers user in DB for Re-Authentication Before Actions
  # Digest is in DB, URL Safe to The APP
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  # Returns true if the users remember token is decrypted to the hash
  # Decrypts token and makes sure it matches the digest
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def is_admin? 
    admin 
  end


  class << self

    # Returns a hash digest of a given String
    def digest(str)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(str, cost: cost )
    end

    # returns a random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

end
