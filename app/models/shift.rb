class Shift < ApplicationRecord
  attribute :start_date, :date
  attribute :start_time, :datetime

  belongs_to :user
  belongs_to :organisation

  validates :start, :finish, :break, presence: true

  def hours
    (self.finish - self.start - (self.break * 60)) / 3600
  end

  def sunday_hours
    if self.start.wday == 6
      @sunday_hours = self.start - self.finish.midnight
      if @sunday_hours >= 0
        self.hours
      else
        @sunday_hours / 3600
      end
    else
      0
    end
  end
end
