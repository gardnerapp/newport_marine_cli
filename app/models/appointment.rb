class Appointment < ApplicationRecord
  belongs_to :user
  has_many :services
  # todo figure out indexes to add to the appointments and services join table
end
