class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :patient, dependent: :destroy
  has_one :doctor, dependent: :destroy

  def self.user_doctor(user)
    @id = user.doctor.id
    @doctor = Doctor.where('id = ?', @id)
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.open_users
    User.all.select { |u| u.mdmarker == false && u.patient == nil }
  end

  def self.possible_patients
    User.all.select { |u| u.mdmarker == false }
  end

  def self.possible_doctors
    User.all.select { |u| u.mdmarker == true }
  end
end
