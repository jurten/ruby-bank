class Turn < ApplicationRecord
  enum status: [:pending, :canceled, :finished]
  belongs_to :branch, optional: true
  belongs_to :user
  belongs_to :staff, optional: true, class_name: 'User'


  validates :date, presence: true
  validates :reason, presence: true
  validates :comment, presence: true, on: :update, if: -> {  !staff_id.blank? }

  validate :date_is_within_branch_hours


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

  #make a method that returns a boolean if the turn is within the branch hours
  def date_is_within_branch_hours
    if branch
      if !branch.day_is_within_branch_hours? date.wday, date.strftime("%H:%M")
        errors.add(:date, "La fecha no esta dentro del horario de la sucursal")
      end
    end
  end
  
end
