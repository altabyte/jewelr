require 'color'

class Fixnum

  # Convert this integer value to a hash of r, g, b values.
  #
  # Example:
  #
  #    123456.to_rgb  =>  { r: 1, g: 226, b: 64 }
  #
  # @return [Hash] with keys :r, :g, :b.
  #
  # @see http://codegolf.stackexchange.com/questions/43155/convert-rgb-integer-value-into-rgb-values
  #
  def to_rgb
    rgb = [16, 8, 0].map {|x| self >> x & 255 }
    { r: rgb[0], g: rgb[1], b: rgb[2] }
  end
end


module Color
  class RGB

    # Create a new Color::RGB from a single integer value.
    #
    # @param [Fixnum] an integer in the range 0 to 16777215.
    #
    # @return [Color::RGB] the corresponding RGB color.
    #
    def RGB.from_i(rgb_integer_value = 0)
      max = 16777215.freeze
      rgb_integer_value = 0 if rgb_integer_value.to_i <= 0
      rgb_integer_value = max if rgb_integer_value > max
      rgb = rgb_integer_value.to_rgb
      Color::RGB.new(rgb[:r], rgb[:g], rgb[:b])
    end

    # Convert this RGB color into an integer representation.
    #
    # @return [Fixnum] corresponding integer value in the range 0 to 16777215.
    #
    def to_i
      # Bitwise operator removes the need for multiplication.
      # If you know that your r, g, and b values are never > 255 or < 0 you don't need the & 0x0ff
      ((red.to_i & 0x0ff) << 16) | ((green.to_i & 0x0ff) << 8) | (blue.to_i & 0x0ff)
    end
  end
end
