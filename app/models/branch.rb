class Branch < ApplicationRecord 
  has_many :schedules, dependent: :destroy
  validates :name, :address, :phone, presence: true
  validates :name, uniqueness: true
end
