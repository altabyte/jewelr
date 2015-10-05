class Ingredient < ActiveRecord::Base
  belongs_to :description
  belongs_to :material

  acts_as_list scope: :description

  enum significance: { primary: 0, secondary: 1, tertiary: 2 }

  # Get the name of the material used in this component.
  def name(locale = :en)
    self.material.name(locale)
  end
end
