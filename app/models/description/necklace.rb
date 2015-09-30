class Description::Necklace < Description

  CLOSURE_TYPES = ['Lobster', 'Magnetic', 'Spring Ring']

  store_accessor :properties, :closure
  store_accessor :properties, :length
  store_accessor :properties, :strands

  before_validation :fix_strands

  #---------------------------------------------------------------------------
  private

  def fix_strands
    properties[:strands] = (properties[:strands] ||  1).to_i
    properties[:strands] = 1 if properties[:strands] < 1
  end

end
