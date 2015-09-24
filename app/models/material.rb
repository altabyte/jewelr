require 'serializers/hash_serializer'

class Material < ActiveRecord::Base
  include UniquelyIdentifiable

  serialize :names,   HashSerializer
  serialize :aliases, HashSerializer

  store_accessor :names, :name_en, :name_zh, :name_pinyin
  store_accessor :aliases, :alias_en

  before_validation :correct_names
  before_validation :correct_aliases

  # TODO: cannot currently set `uniqueness: true`
  validates :name_en, presence: true

  # Get the material name for the specified locale and fall back to :en if locale is not found.
  # @param [Symbol] locale the international locale code.
  # @return [String] the material name.
  #
  def name(locale = :en)
    key = "name_#{locale.to_s}"
    name = self.names[key]
    name = self.name_en if name.blank?
    name
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

  def correct_names
    self.names.each_pair do |key, value|
      value = value.to_s.strip.gsub(/[\s]+/, ' ')
      value = nil if value.blank?
      self.names[key] = value
    end
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
