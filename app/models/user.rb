class User < ApplicationRecord
  before_save {email.downcase!}
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
            uniqueness: {case_sensitive: false}
  validates :phone, presence: true #, uniqueness: true
  validates :password_digest, presence: true, length: {minimum: 6}
  # 1. saves password digest attribute to db
  # 2. adds password and confirmation presence and equal validations
  # 3. the auth method returns user if pWord is correct
  has_secure_password

  # has_one :boat
end
