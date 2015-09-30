class Description::Bead < Description

  HOLE_DIRECTIONS = {
      1 => 'Front to back',
      2 => 'Left to right'
  }

  store_accessor :properties, :length, :width, :thickness
  store_accessor :properties, :hole_diameter, :hole_direction

  def cabochon?
    hole_diameter <= 0
  end

end
