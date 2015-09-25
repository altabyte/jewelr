class MaterialsController < ApplicationController

  before_action :set_material, only: [:show, :edit, :update, :destroy]
  before_action :set_type

  # GET /materials
  def index
    case type
      when Material::Gemstone.name
        @materials = Material.gemstones
      when Material::ManMade.name
        @materials = Material.man_mades
      when Material::Metal.name
        @materials = Material.metals
      else
        @materials = Material.all
    end
  end

  # GET /materials/1
  def show
  end

  # GET /materials/new
  def new
    @material = type_class.new
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials
  def create
    @material = Material.new(material_params)

    if @material.save
      redirect_to redirect_path_for(@material), notice: "#{@material.type} '#{@material.name}' has been created."
    else
      render :new
    end
  end

  # PATCH/PUT /materials/1
  def update
    if @material.update(material_params)
      redirect_to redirect_path_for(@material), notice: 'Material was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /materials/1
  def destroy
    @material.destroy
    redirect_to materials_url, notice: 'Material was successfully destroyed.'
  end

  #---------------------------------------------------------------------------
  private

  def set_type
    @type = type
  end

  def type
    type = params[:type]
    return nil unless type
    type = "#{Material.name}::#{type.gsub('-', '_').camelize}"
    Material.type_names.include?(type) ? type : Material.name
  end

  def type_class
    type.constantize
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_material
    @material = type_class.find(params[:id])
  end

  def redirect_path_for(material)
    case material
      when Material::Gemstone then
        gemstones_path
      when Material::ManMade then
        man_mades_path
      when Material::Metal then
        metals_path
      else
        materials_path
    end
  end

  # Only allow a trusted parameter "white list" through.
  def material_params
    key = type.underscore.gsub('/', '_').to_sym # form will typically submit 'material/gemstone'
    params.require(key).permit(:type,
                               :parent_id,
                               :name_en,
                               :name_zh,
                               :name_pinyin,
                               :description,
                               :notes,
                               :selectable,
                               :inherit_display_name)
  end
end
