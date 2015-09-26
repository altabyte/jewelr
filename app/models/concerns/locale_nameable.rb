module LocaleNameable
  extend ActiveSupport::Concern

  included do
    serialize :names,   HashSerializer

    store_accessor :names, :name_en, :name_zh, :name_pinyin

    before_validation :correct_names
  end

  # Get the name for the specified locale and fall back to :en if locale is not found.
  # @param [Symbol] locale the international locale code.
  # @return [String] the name.
  #
  def name(locale = :en)
    key = "name_#{locale.to_s}"
    name = self.names[key]
    name = self.name_en if name.blank?
    name
  end

  #---------------------------------------------------------------------------
  private

  def correct_names
    self.names.each_pair do |key, value|
      value = value.to_s.strip.gsub(/[\s]+/, ' ')
      value = nil if value.blank?
      self.names[key] = value
    end
  end
end
