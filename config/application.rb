require File.expand_path('../boot', __FILE__)

require 'rails'

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

require_relative 'uid_options'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jewelr
  class Application < Rails::Application

    # Change schema dump format to SQL as Hstore cannot be represented in Ruby.
    config.active_record.schema_format = :sql

    config.uid = UidOptions.new
    # Perhaps move the following options to an initializer file?
    config.uid.index_source   = :redis
    config.uid.digits         = 7
    config.uid.per_file       = 1_000_000
    config.uid.path           = Rails.root.join('config/uids')
    config.uid.file_prefix    = 'uids_'
    config.uid.file_extension = '.txt'
    config.uid.seed           = ENV['UID_GENERATOR_SEED'].to_i

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
