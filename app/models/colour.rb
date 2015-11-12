require 'color'

# A Colour model must always be initialized with an RGB integer value.
# The HSL values will then be calculated from the RGB.
#
class Colour < ActiveRecord::Base

  before_validation :derive_hsl_from_rgb
  #before_save(on: :create) { find_named_colour }

  validates :hue,        presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 360 }
  validates :saturation, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :luminosity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :rgb,        presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def rgb
    to_i ? to_i.to_rgb_color : nil
  end

  def rgb=(value)
    begin
      value = Color::RGB.from_html(value) if value.is_a?(String) && value =~ /^#[0-9A-F]+$/i
      value = value.to_i if value.is_a?(Color::RGB)
      write_attribute :rgb, value if value.is_a?(Fixnum)
    rescue Exception => e
      logger.error e.message
    end
  end

  def hsl
    Color::HSL.new(self.hue, self.saturation, self.luminosity)
  end

  def to_i
    read_attribute(:rgb)
  end

  def hex
    rgb.hex
  end

  #--------------------------------------------------------------------------
  private

  def derive_hsl_from_rgb
    unless self.to_i.blank?
      hsl = self.rgb.to_hsl
      self.hue, self.saturation, self.luminosity = hsl.hue, hsl.saturation, hsl.luminosity
    end
  end

  def find_named_colour
    self.name_id = NamedColour::RoyalBlue.rgb
  end
end


module NamedColour
  _struct = Struct.new(:rgb, :h, :s, :l, :name_en, :theme, :amazon, :ebay)

  RoyalBlue = _struct.new(12345, 30, 50, 85, 'Royal Blue', :blue) do

    def name(locale = en)
      name_en
    end

  end

end
