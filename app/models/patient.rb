class Patient < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :doctors, through: :appointments

  def name(patient)
    @patient = User.select { |p| }
  end

  def full_name
    @user = User.all.select { |u| u.id == self.user_id }
    "#{@user[0].first_name} #{@user[0].last_name}"
  end
end


