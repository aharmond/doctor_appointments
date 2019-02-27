class Patient < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :doctors, through: :appointments

  def name(patient)
    @patient = User.where(['id = ?', patient.id])
  end
end


