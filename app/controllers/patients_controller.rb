class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all
  end

  def patient_index
    @pat = @doctor.patients.all
  end

  def show
  end

  def new
    @users = User.open_users
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save 
      redirect_to doctors_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path
  end

  def home
    if current_user.mdmarker == true
      redirect_to doctors_path
    elsif current_user.mdmarker == false
      redirect_to patients_path
    else
      redirect_to new_user_session_path
    end
  end

  private
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:user_id)
    end
end
