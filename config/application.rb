require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Openhunt
  class Application < Rails::Application

    require "ext/serialize_ext"
    require "ext/date_ext"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths << "#{Rails.root}/lib"
    config.autoload_paths << "#{Rails.root}/app/forms"
    config.autoload_paths << "#{Rails.root}/app/workers"

    config.assets.paths << Rails.root.join("app-js")
    config.assets.paths << Rails.root.join("app-css")

    config.assets.paths << Rails.root.join("vendor", "assets", "fonts")
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.assets.precompile += %w( application.css application.js )
    config.assets.precompile += %w( dependencies.css dependencies.js )
    config.assets.precompile += %w( .svg .eot .woff .ttf)

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # default to production react mode
    config.react.variant = :production

  end
end
