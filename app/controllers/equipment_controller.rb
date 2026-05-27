class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    equipment_list = Equipment.includes(:category).order(:name)

    if params[:status].present?
      equipment_list = equipment_list.where(status: params[:status])
    end

    render json: equipment_list.as_json(include: { category: { only: :name } })
  end

  def show
    records = @equipment.maintenance_records.order(performed_at: :desc)

    render json: @equipment.as_json(include: { category: { only: :name } }).merge(maintenance_records: records)
  end

  def create
    equipment = Equipment.new(equipment_params)

    if equipment.save
      render json: equipment, status: :created
    else
      render json: { errors: equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @equipment.update(equipment_params)
      render json: @equipment
    else
      render json: { errors: @equipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @equipment.destroy
    head :no_content
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :serial_number, :status, :category_id)
  end

  def record_not_found
    render json: { error: "Equipment not found" }, status: :not_found
  end
end
