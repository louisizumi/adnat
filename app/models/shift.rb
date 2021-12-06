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
    @finish_without_break = Time.parse(self.finish.to_s) - (self.break * 60)
    if self.start.wday == 0 && @finish_without_break.wday == 0
      return self.hours
    elsif self.start.wday == 0 && @finish_without_break.wday == 1
      return (@finish_without_break - self.start.end_of_day) / 3600
    elsif self.start.wday == 6 && @finish_without_break.wday == 0
      return (@finish_without_break.midnight - self.start) / 3600
    else
      return 0
    end
  end
end
