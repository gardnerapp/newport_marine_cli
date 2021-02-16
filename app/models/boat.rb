class Boat < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :location, presence: true, length: { maximum: 100 }
  validates :length, presence: true
end
