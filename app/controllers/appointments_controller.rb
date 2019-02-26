class AppointmentsController < ApplicationController
  before_action :set_patient
  before_action :set_appointment, only: [:edit, :update, :destroy]
  
  def index
    @appointments = @patients.appointments
  end

  def new
    @appointment = @patient.appointments.new
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
      params.require(:appointments).permit(:date, :doctor_id)
    end
end
