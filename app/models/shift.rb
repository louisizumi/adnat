class Shift < ApplicationRecord
  belongs_to :user

  validates :start, :finish, :break, presence: true
end
