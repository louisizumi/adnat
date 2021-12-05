class Shift < ApplicationRecord
  attribute :start_date, :date
  attribute :start_time, :datetime

  belongs_to :user

  validates :start, :finish, :break, presence: true
end
