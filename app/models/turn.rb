class Turn < ApplicationRecord
  enum status: [:pending, :canceled, :finished]
  belongs_to :branch, optional: true
  belongs_to :user
  belongs_to :staff, optional: true, class_name: 'User'


  validates :date, presence: true
  validates :reason, presence: true
  validates :comment, presence: true, on: :update, if: -> {  !staff_id.blank? }

  validate :date_is_within_branch_hours

  validate :date_is_not_in_the_past
  
  def date_is_not_in_the_past
    if date.present?
      if date < Date.today
        errors.add(:date, "La fecha no puede ser en el pasado")
      end
    end
  end

  def status_to_s
    case self[:status]
    when "pending"
      "Pendiente"
    when "canceled"
      "Cancelado"
    when "finished"
      "Atendido"
    end
  end

  #make a method that returns true if the turn datetime is within the branch schedule
  def date_is_within_branch_hours
    if branch
      unless branch.day_is_within_branch_hours?(date.wday, date.strftime("%H:%M"))
        errors.add(:date, "La fecha no se encuentra dentro del horario de atención de la sucursal")
      end
    end
  end
  
end
