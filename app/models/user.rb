class User < ApplicationRecord
  enum role: [:client, :admin, :staff]

  def role_to_s
    case self[:role]
    when "client"
      "Cliente"
    when "admin"
      "Administrador"
    when "staff"
      "Empleado"
    end
  end

  #make a method that return the branch name of the user using a integer pass as parameter
  def branch_name(branch_id)
    Branch.find(branch_id).name
  end


  validates :branch_id, presence: true, if: :staff?
  validates :branch_id, absence: true, if: :admin?
  validates :branch_id, absence: true, if: :client?
  #validate email and password presence on create write the error messages in spanish
  validates :email, presence: { message: "El correo electrónico es obligatorio" },on: :create
  validates :password, presence: { message: "La contraseña es obligatoria" },on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
