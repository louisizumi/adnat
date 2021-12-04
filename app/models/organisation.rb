class Organisation < ApplicationRecord
  has_many :users
  has_many :shifts, through: :users

  validates :name, :hourly_rate, presence: true
end
