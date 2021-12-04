class Organisation < ApplicationRecord
  has_many :users
  has_many :shifts, through: :users

  validates :name, :hourly_rate, presence: true
  validates :name, length: { in: 2..64 }, uniqueness: true
  validates :hourly_rate, numericality: { greater_than: 0.0, less_than: 100.01 }
end
