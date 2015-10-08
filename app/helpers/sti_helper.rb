module StiHelper

  # http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-3/
  def sti_material_path(material = nil, type = Material.name, action = nil)
    send "#{format_sti(material, type, action)}_path", material
  end

  def sti_description_path(description = nil, type = Description.name, action = nil)
    send "#{format_sti(description, type, action)}_path", description
  end

  #---------------------------------------------------------------------------
  private

  def format_sti(object, type, action)
    type = type.to_s.split(':').last  # Convert 'Material::Gemstone' to 'Gemstone'
    action = nil unless %w'new edit'.include? action.to_s
    action || object ? "#{format_sti_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_sti_action(action)
    action ? "#{action}_" : ''
  end
end
