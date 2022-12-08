class Schedule < ApplicationRecord
  enum days: [ :Lunes, :Martes, :Miercoles, :Jueves, :Viernes, :Sabado, :Domingo ]

  def self.i_to_days num
    days.invert[num]
  end

  belongs_to :branch
  validates :day, :start, :finish, presence: true
  validates :finish, comparison: { greater_than: :start , message: ": El tiempo de finalización debe ser mayor al de inicio"}

  validates :day, uniqueness: { scope: :branch_id,
                              message: "Ya existe un horario para este dia" }

end
