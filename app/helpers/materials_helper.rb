module MaterialsHelper

  def material_simple_form_url(material)
    name = (material.type || Material.name).split(':').last.underscore
    url = "#{MaterialsController::TYPE_ROUTE_PREFIX}/#{name}s"
    url << "/#{material.id}" unless material.new_record?
    url
  end


  def render_material_index_list(materials_hash, locale = :en)
    return unless materials_hash && materials_hash.is_a?(Hash)

    string = ''
    traverse_materials_tree materials_hash, locale do |material, depth|
      string << '<li>'
      string << "<span class='material-name'>"
      (0...depth).each { string << '&nbsp; &nbsp; ' }
      string << link_to(material.name(locale), sti_material_path(material, material.type, :edit))
      string << '</span>'
      string << link_to('+', "#{sti_material_path(nil, material.type, :new)}?p=#{material.id}", class: 'add-new-material')
      string << barcode(material.id)
      #string << link_to('Show', sti_material_path(material.type, material))
      #string << link_to('Edit', sti_material_path(material.type, material, :edit))
      #string << link_to('×', sti_material_path(material.type, material), method: :delete, data: { confirm: 'Do you really want to delete this material?' })
      string << '</li>'
    end
    string.html_safe
  end


  def material_parent_select_options(material, locale = 'en')
    materials = Material.gemstones.hash_tree  if material.type == Material::Gemstone.name
    materials = Material.man_mades.hash_tree  if material.type == Material::ManMade.name
    materials = Material.metals.hash_tree     if material.type == Material::Metal.name

    options = []
    unless materials.nil? || materials.empty?
      traverse_materials_tree materials, locale do |material, depth|
        name = ''
        (1..depth).each { name << ' &nbsp;' }
        name << material.name
        options << [name.html_safe, material.id]
      end
    end
    options
  end


  def material_tree_breadcrumbs(material)
    string = ''
    ancestors = []
    if material.parent
      ancestors = [material.parent, material.parent.ancestors].flatten
    end
    ancestors.reverse.each do |ancestor|
      string << ' > ' unless string.blank?
      #string << link_to(ancestor.name, material_path(ancestor))
      string << ancestor.name
    end
    string.html_safe
  end


  #---------------------------------------------------------------------------
  private

  # Perform a deep traversal of the materials ordered hash, starting at the
  # specified node and execute the given block for each material in the tree.
  #
  # @see https://github.com/mceachen/closure_tree#nested-hashes
  #
  def traverse_materials_tree(hash, locale, depth = 0, &block)
    keys = hash.keys.sort_by { |material| material.name(locale) }
    keys.each do |key|
      value = hash[key]
      yield key, depth if block_given?
      traverse_materials_tree(value, locale, depth + 1, &block)
    end
  end
end
