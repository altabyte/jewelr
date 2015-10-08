module DescriptionsHelper

  def description_simple_form_url(description)
    name = (description.type || Description.name).split(':').last.underscore
    url = "#{DescriptionsController::TYPE_ROUTE_PREFIX}/#{name}s"
    url << "/#{description.id}" unless description.new_record?
    url
  end

end
