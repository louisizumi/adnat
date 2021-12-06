class Shift < ApplicationRecord
  attribute :start_date, :date
  attribute :start_time, :datetime

  belongs_to :user
  belongs_to :organisation

  validates :start, :finish, :break, presence: true

  def hours
    (self.finish - self.start - (self.break * 60)) / 3600
  end
end
