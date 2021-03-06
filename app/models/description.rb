class Description < ActiveRecord::Base
  include Sequence7Identifiable

  has_many :colours do
    def <<(colour)
      super unless includes?(colour)
    end

    def includes?(colour)
      where(rgb: colour.rgb).count > 0
    end
  end

  has_many :ingredients, -> { order('position ASC') }
  has_many :materials, -> { distinct }, through: :ingredients

  # Add { _destroy: '1' } to ingredients attributes hash to destroy it from a form submission.
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :colours,     allow_destroy: true

  validates :type, presence: true
  validates :part_count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  monetize :acc_price_cents,
           allow_nil: true,
           with_model_currency: :acc_price_currency,
           numericality: { greater_than: 0 }

  monetize :target_price_cents,
           allow_nil: true,
           with_model_currency: :target_price_currency,
           numericality: { greater_than: 0 }

  enum shop_sec_account: { shop_sec_TT: 1, shop_sec_AR: 2, shop_sec_CS: 3 }

  def archived=(time = true)
    if time.is_a? Time
      self[:archived] = time
    else
      time = time.to_s
      if (time.blank?)
        self[:archived] = nil
      elsif %w'1 true y yes'.include?(time.to_s.strip.downcase)
        self[:archived] = Time.now.utc unless self.archived?
      else
        begin
          self[:archived] = Time.parse(time)
        rescue
          self[:archived] = nil
        end
      end
    end
  end

  def notes=(notes)
    notes = notes.to_s.strip.gsub(/[ \t]+/, ' ')
    self[:notes] = notes.blank? ? nil : notes
  end

  def summary=(summary)
    summary = summary.to_s.strip
    self[:summary] = summary.blank? ? nil : summary
  end
end
