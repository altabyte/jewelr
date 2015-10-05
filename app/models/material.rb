require 'serializers/hash_serializer'

class Material < ActiveRecord::Base
  include UniquelyIdentifiable
  include LocaleNameable

  # http://szeliga.me/sorting-active-record-relation-by-postgresql-hstore-value/
  acts_as_tree # order: 'name_en -> "names"'

  has_many :ingredients
  has_many :descriptions, through: :ingredients

  store_accessor :aliases, :alias_en
  serialize      :aliases, HashSerializer

  before_validation :correct_aliases

  validates :type, presence: true

  # TODO: cannot currently set `uniqueness: true`
  validates :name_en, presence: true

  class << self
    def types
      [ Material::Gemstone, Material::Metal, Material::ManMade ]
    end

    def type_names
      types.map { |type| type.name }
    end
  end

  scope :metals,    -> { where(type: Material::Metal.name) }
  scope :gemstones, -> { where(type: Material::Gemstone.name) }
  scope :man_mades, -> { where(type: Material::ManMade.name) }

  def type_class
    self.type.constantize
  end

  def gemstone?
    type_class == Material::Gemstone
  end

  def metal?
    type_class == Material::Metal
  end

  def man_made?
    type_class == Material::ManMade
  end

  def notes=(string)
    string = nil if string.blank?
    string.strip! if string.is_a?(String)
    self[:notes] = string
  end

  def description=(string)
    string = nil if string.blank?
    string.strip! if string.is_a?(String)
    self[:description] = string
  end


  #---------------------------------------------------------------------------
  private

  def valid_locales
    [:en, :zh, :pinyin]
  end

  def correct_aliases
    valid_locales.each do |locale|
      key = "alias_#{locale}"
      value = self.aliases[key] || []
      value = value.split(',') if value.is_a?(String)
      value.select! { |name| !name.blank? }
      value.map!    { |name| name.to_s.strip.capitalize }
      self.aliases[key] = value.sort
    end
  end
end
