require 'serializers/hash_serializer'

class User < ActiveRecord::Base
  include Sequence9Identifiable

  AUTH_TOKEN_LENGTH = 100

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  store_accessor :preferences, :locale

  # http://nandovieira.com/using-postgresql-and-jsonb-with-ruby-on-rails
  serialize :preferences, HashSerializer

  before_validation(on: :create) {
    init_default_preferences
    ensure_authentication_token
  }
  before_validation { ensure_user_id }

  validates :username, presence: true
  validates :authentication_token, presence: true

  def username=(username)
    self[:username] = username.blank? ? nil : username.strip
  end

  # Get the user's preferred locale.
  # @return [Symbol] locale, eg :en
  def locale
    (self.preferences['locale'] || I18n.default_locale).to_sym
  end

  def locale=(locale)
    self.preferences['locale'] = locale if I18n.locale_available?(locale)
    self.locale
  end

  def generate_authentication_token(length = AUTH_TOKEN_LENGTH)
    loop do
      token = Devise.friendly_token(length)
      unless User.where(authentication_token: token).first
        self.authentication_token = token
        break
      end
    end
  end

  #---------------------------------------------------------------------------
  private

  def ensure_user_id
    self.username = self.id.to_s if self.username.blank?
  end

  def ensure_authentication_token
    generate_authentication_token if self.authentication_token.blank?
  end

  def init_default_preferences
    self.locale = I18n.default_locale
  end
end
