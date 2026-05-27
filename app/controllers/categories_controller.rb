class CategoriesController < ApplicationController
  # This runs the 'set_category' method before the show, update, and destroy actions
  before_action :set_category, only: [:show, :update, :destroy]

  # If a category isn't found, it automatically runs the 'record_not_found' method
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /categories
  def index
    categories = Category.order(:name)
    render json: categories
  end

  # GET /categories/:id
  def show
    # We merge the category data with the equipment count as required by the lab
    render json: @category.as_json.merge(equipment_count: @category.equipment.count)
  end

  # POST /categories
  def create
    category = Category.new(category_params)

    if category.save
      render json: category, status: :created # 201 status code
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity # 422 status code
    end
  end

  # PATCH /categories/:id
  def update
    if @category.update(category_params)
      render json: @category # 200 status code
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity # 422 status code
    end
  end

  # DELETE /categories/:id
  def destroy
    if @category.equipment.any?
      # 409 Conflict if equipment exists
      render json: { error: "Cannot delete category. #{@category.equipment.count} equipment items still belong to it." }, status: :conflict
    else
      @category.destroy
      head :no_content # 204 status code with an empty body
    end
  end

  private

  # Finds the specific category based on the ID in the URL
  def set_category
    @category = Category.find(params[:id])
  end

  # Security: Only allows the 'name' parameter to pass through
  def category_params
    params.require(:category).permit(:name)
  end

  # The custom error message for a 404
  def record_not_found
    render json: { error: "Category not found" }, status: :not_found
  end
end
