class Shift < ApplicationRecord
  belongs_to :user

  validates :start, :finish, :break, presence: true
  validate :shift_length

  def shift_length
    if start > finish
      errors.add(:finish, "Shift finish time cannot be before shift start time.")
    end
  end
end
