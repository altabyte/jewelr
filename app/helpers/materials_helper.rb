module MaterialsHelper

  def material_simple_form_url(material)
    name = (material.type || Material.name).split(':').last.underscore
    url = "/#{name}s"
    url << "/#{material.id}" unless material.new_record?
    url
  end
end
