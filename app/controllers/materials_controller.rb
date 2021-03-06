class MaterialsController < ApplicationController

  # A prefix to be prepend to material routes.
  # Eg. The route to Material::Gemstone would be '/material/gemstones'
  TYPE_ROUTE_PREFIX = '/material'

  before_action :authenticate_user!
  before_action :set_material, only: [:show, :edit, :update, :destroy]
  before_action :set_parent, only: [:new, :edit, :update]
  before_action :set_type

  # GET /materials
  def index
    case type.name
      when Material::Gemstone.name
        @materials = Material.gemstones
        @materials_hash = Material.gemstones.hash_tree
      when Material::ManMade.name
        @materials = Material.man_mades
        @materials_hash = Material.man_mades.hash_tree
      when Material::Metal.name
        @materials = Material.metals
        @materials_hash = Material.metals.hash_tree
      else
        @materials = Material.all
        @materials_hash = Material.hash_tree
    end
  end

  # GET /materials/1
  def show
  end

  # GET /materials/new
  def new
    redirect_to(materials_path, notice: 'Undefined parent') and return unless @parent
    @material = type.new
    @material.parent = @parent
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

  def type
    unless @type
      begin
        type_name = params.key?(:type) ? "#{Material.name}::#{params[:type].gsub('-', '_').camelize}" : Material.name
        @type = type_name.constantize
      rescue
        @type = Material
      end
    end
    @type
  end

  def set_type
    @type = type
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_material
    begin
      @material = type.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to materials_path, alert: "Could not find #{type.name.split(':').last} with ID #{params[:id]}!"
    end
  end

  def set_parent
    return unless params[:p]
    @parent = type.find(params[:p]) if type.exists?(params[:p])
    @parent_id = @parent.nil? ? nil : @parent.id
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
    key = type.name.underscore.gsub('/', '_').to_sym # form will typically submit 'material/gemstone'
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
