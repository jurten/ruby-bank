class Branch < ApplicationRecord 
  has_many :users, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :turns, dependent: :destroy
  validates :name, :address, :phone, presence: true
  validates :name, uniqueness: true

  #make a method that checks if a day is within the branch hours
  def time_format time
  time.hour.to_s + ":" + time.min.to_s
  end

  def day_is_within_branch_hours? day, time
    schedule = schedules.find_by(day: day)
    if schedule
      time_format(schedule.start).to_time <= time.to_time && time_format(schedule.finish).to_time >= time.to_time
    else
      false
    end
  end
end
