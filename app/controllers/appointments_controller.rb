class AppointmentsController < ApplicationController
  before_action :set_patient, except: [:new, :create]
  before_action :set_appointment, only: [:edit, :update, :destroy]
  
  def index
    @appointments = @patients.appointments
  end

  def new
    @patients = User.possible_patients
    @doctors = User.possible_doctors
    
    if current_user.patient == nil
      @doctor = current_user.doctor
      @appointment = @doctor.appointments.new
    elsif current_user.doctor == nil
      @patient = current_user.patient
      @appointment = @patient.appointments.new
    end
  end

  def create
    @appointment = @patient.appointments.new(appointment_params)

    if @appointment.save 
      redirect_to patient_appointments_path(@patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to patient_appointments_path(@patient)
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to patient_appointments_path(@patient)
  end

  private
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    def set_appointment
      @appointment = @patient.appointments.find(params[:id])
    end

    def appointment_params
      params.require(:appointments).permit(:date, :doctor_id, :patient_id)
    end
end
