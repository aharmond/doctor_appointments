class AppointmentsController < ApplicationController
  before_action :set_patient, except: [:new, :create, :destroy]
  before_action :set_appointment, only: [:edit, :update, :destroy]
  
  def index
    @appointments = @patients.appointments
  end

  def new
    if current_user.doctor != nil
      @doctor = current_user.doctor
      @appointment = @doctor.appointments.new
    elsif current_user.patient != nil
      @patient = current_user.patient
      @appointment = @patient.appointments.new
    end
  end

  def create
    if current_user.doctor != nil
      @doctor = current_user.doctor
      @appointment = @doctor.appointments.new(appointment_params)
      if @appointment.save
        redirect_to doctor_path(@doctor)
      else
        render :new
      end
    elsif current_user.patient != nil
      @patient = current_user.patient
      @appointment = @patient.appointments.new(appointment_params)
      if @appointment.save 
        redirect_to patient_path(@patient)
      else
        render :new
      end
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
    if current_user.doctor != nil
      @doctor = current_user.doctor
      redirect_to doctor_path(@doctor)
    elsif current_user.patient != nil
      @patient = current_user.patient
      redirect_to patient_path(@patient)
    end
  end

  private
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    def set_appointment
      if current_user.patient != nil
        @patient = current_user.patient  
        @appointment = @patient.appointments.find(params[:id])
      elsif current_user.doctor != nil
        @doctor = current_user.doctor
        @appointment = @doctor.appointments.find(params[:id])
      end
    end

    def appointment_params
      params.require(:appointment).permit(:date, :doctor_id, :patient_id)
    end
end
