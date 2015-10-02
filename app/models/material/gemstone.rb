class Material::Gemstone < Material

  store_accessor :properties, :natural
  store_accessor :properties, :treatments

  def natural?
    properties['natural'] ||= true
  end

  def natural
    natural?
  end

  def natural=(value)
    properties['natural'] = %w'true, yes, 1'.include?(value.to_s)
  end
end
