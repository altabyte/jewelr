require 'color'
require 'colours/names'

# A Colour model must always be initialized with an RGB integer value.
# The HSL values will then be calculated from the RGB.
#
class Colour < ActiveRecord::Base
  include Colours::Names

  belongs_to :description

  acts_as_list scope: :description

  before_validation :derive_hsl_from_rgb

  validates :hue,        presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 360 }
  validates :saturation, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :luminosity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :rgb,        presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # Get the RGB value of this colour.
  # @return [Color::RGB] an RGB object.
  #
  def rgb
    to_i ? to_i.to_rgb_color : nil
  end

  # Define this colour using RGB notation.
  # @param [Fixnum|String|Color::RGB] value RGB colour representation.
  #
  def rgb=(value)
    begin
      value = Color::RGB.from_html(value) if value.is_a?(String) && value =~ /^#[0-9A-F]+$/i
      value = value.to_i if value.is_a?(Color::RGB)
      write_attribute :rgb, value if value.is_a?(Fixnum)
    rescue Exception => e
      logger.error e.message
    end
  end

  # Get the value of this colour in HSL notation.
  # @return [Color::HSL] the corresponding colour in HSL.
  #
  def hsl
    Color::HSL.new(self.hue, self.saturation, self.luminosity)
  end

  # Get the RGB integer representation of this colour.
  # @return [Fixnum] the value of RGB.to_i
  #
  def to_i
    read_attribute(:rgb)
  end

  # Get the RGB hexadecimal value of this colour.
  # @return [String] the HTML/hex colour code.
  #
  def hex
    rgb.hex
  end

  # Retrieve the NamedColour struct containing details of the closest matching colour from the list in {Colours::Names}.
  # @return [Colours::Names::NamedColour]
  #
  def name_struct
    hue_min = self.hue - 10.0
    hue_max = self.hue + 10.0

    near_by = named_colours_between(hue_min, hue_max)
    return nil if near_by.empty?

    # Build an array of Colour::RGB objects.
    rgb_list = near_by.map { |named| named.id.to_rgb_color }

    rgb_match = self.rgb.closest_match(rgb_list)
    matches = near_by.select { |named| named.hex == rgb_match.html.upcase }
    matches.empty? ? nil : matches.first
  end

  # Get the name of this colour.
  # @param [Symbol] type can be one of [:en, :ebay, :amazon]
  # @return [String] the colour name.
  #
  def name(type = :en)
    name_struct.name(type)
  end

  #--------------------------------------------------------------------------
  private

  def derive_hsl_from_rgb
    unless self.to_i.blank?
      hsl = self.rgb.to_hsl
      self.hue, self.saturation, self.luminosity = hsl.hue, hsl.saturation, hsl.luminosity
    end
  end
end
