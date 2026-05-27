class MaintenanceRecordsController < ApplicationController
  before_action :set_maintenance_record, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    records = MaintenanceRecord.includes(:equipment).order(performed_at: :desc)

    if params[:equipment_id].present?
      records = records.where(equipment_id: params[:equipment_id])
    end

    render json: records.as_json(include: { equipment: { only: [:name, :serial_number] } })
  end

  def show
    render json: @maintenance_record.as_json(include: { equipment: { only: [:name, :serial_number] } })
  end

  def create
    maintenance_record = MaintenanceRecord.new(maintenance_record_params)

    if maintenance_record.save
      render json: maintenance_record, status: :created
    else
      render json: { errors: maintenance_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @maintenance_record.update(maintenance_record_params)
      render json: @maintenance_record
    else
      render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @maintenance_record.destroy
    head :no_content
  end

  private

  def set_maintenance_record
    @maintenance_record = MaintenanceRecord.find(params[:id])
  end

  def maintenance_record_params
    params.require(:maintenance_record).permit(:description, :performed_at, :equipment_id)
  end

  def record_not_found
    render json: { error: "Maintenance record not found" }, status: :not_found
  end
end
