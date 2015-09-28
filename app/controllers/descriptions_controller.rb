class DescriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_description, only: [:show, :edit, :update, :destroy]

  # GET /descriptions
  def index
    @descriptions = Description.all
  end

  # GET /descriptions/1
  def show
  end

  # GET /descriptions/new
  def new
    @description = Description.new
  end

  # GET /descriptions/1/edit
  def edit
  end

  # POST /descriptions
  def create
    @description = Description.new(description_params)

    if @description.save
      redirect_to @description, notice: 'Description was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /descriptions/1
  def update
    if @description.update(description_params)
      redirect_to @description, notice: 'Description was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /descriptions/1
  def destroy
    @description.destroy
    redirect_to descriptions_url, notice: 'Description was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_description
      @description = Description.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def description_params
      params.require(:description).permit(
          :type,
          :acc_price,
          :target_price,
          :unique,
          :weight_net,
          :weight_gross,
          :archived,
          :packaged_size_x,
          :packaged_size_y,
          :packaged_size_z)
    end
end
