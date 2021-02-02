class User < ApplicationRecord
  has_one :boat



  # 1. saves password digest attribute to db
  # 2. adds password and confirmation presence and equal validations
  # 3. the auth method returns user if pWord is correct
  has_secure_password
end
