class Branch < ApplicationRecord 
  has_many :schedules, dependent: :destroy
  validates :name, :address, :phone, presence: true
  validates :name, uniqueness: true

  #make a method that checks if a day is within the branch hours
  def day_is_within_branch_hours? day, time
    schedule = schedules.find_by(day: day)
    if schedule
      schedule.start <= time && schedule.finish >= time
    else
      false
    end
  end
end
