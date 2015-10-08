class DescriptionsController < ApplicationController

  # A prefix to be prepend to description routes.
  # Eg. The route to Description::Necklace would be '/describe/necklaces'
  TYPE_ROUTE_PREFIX = '/describe'

  before_action :authenticate_user!
  before_action :set_description, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  before_action :gon_materials, only: [:edit, :new]

  # GET /descriptions
  def index
    @descriptions = Description.all
  end

  # GET /descriptions/1
  def show
  end

  # GET /descriptions/new
  def new
    @description = type.new
  end

  # GET /descriptions/1/edit
  def edit
  end

  # POST /descriptions
  def create
    @description = Description.new(description_params)

    if @description.save
      redirect_to redirect_path_for(@description), notice: 'Description was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /descriptions/1
  def update
    if @description.update(description_params)
      redirect_to redirect_path_for(@description), notice: 'Description was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /descriptions/1
  def destroy
    @description.destroy
    redirect_to descriptions_url, notice: 'Description was successfully destroyed.'
  end

  #---------------------------------------------------------------------------
  private

  def type
    unless @type
      begin
        type_name = params.key?(:type) ? "#{Description.name}::#{params[:type].gsub('-', '_').camelize}" : Description.name
        @type = type_name.constantize
      rescue
        @type = Description
      end
    end
    @type
  end

  def set_type
    @type = type
    gon.description_type = type.name.downcase.gsub('::', '_')
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_description
    @description = Description.find(params[:id])
  end

  def redirect_path_for(description)
    descriptions_path
=begin
    case description
      when Description::Necklace then
        necklaces_path
      when Description::Bracelet then
        bracelets_path
      when Description::Earring then
        earrings_path
      else
        descriptions_path
    end
=end
  end

  # Only allow a trusted parameter "white list" through.
  def description_params
    key = type.name.underscore.gsub('/', '_').to_sym # form will typically submit 'description/necklace'
    params.require(key).permit(
        :type,
        :acc_price,
        :target_price,
        :unique,
        :weight_net,
        :weight_gross,
        :archived,
        :packaged_size_x,
        :packaged_size_y,
        :packaged_size_z,
        ingredients_attributes: [
            :id,
            :material_id,
            :genuine,
            :position,
            :significance,
            :_destroy])
  end

  def gon_materials
    gon.materials = []
    Material.all.each do |material|
      gon.materials << {
          value:  material.id,
          en:     material.name_en,
          zh:     material.name_zh,
          pinyin: material.name_pinyin
      }
    end
    gon.materials
  end
end
