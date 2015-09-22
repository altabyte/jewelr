class User < ActiveRecord::Base

  AUTH_TOKEN_LENGTH = 100

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  before_validation(on: :create) { ensure_authentication_token }
  before_validation { ensure_user_id }

  validates :username, presence: true
  validates :authentication_token, presence: true

  def username=(username)
    self[:username] = username.blank? ? nil : username
  end

  def locale
    (self.settings['locale'] || I18n.default_locale).to_sym
  end

  def locale=(locale)
    self.settings['locale'] = locale if I18n.locale_available?(locale)
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
end
