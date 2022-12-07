class Schedule < ApplicationRecord
  enum days: { lunes: 0, martes: 1, miercoles: 2, jueves: 3, viernes: 4, sabado: 5, domingo: 6 }

  belongs_to :branch
  validates :day, :start, :finish, presence: true
  validates :finish, comparison: { greater_than: :start , message: ": El tiempo de finalización debe ser mayor al de inicio"}
  validates :day, inclusion: { in: days, message: "%{value} no es un dia" }

  validates :day, uniqueness: { scope: :branch_id,
                              message: "Ya existe un horario para este dia" }
end
