class Organisation < ApplicationRecord
  has_many :users

  validates :name, :hourly_rate, presence: true
end
