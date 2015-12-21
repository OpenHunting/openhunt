source 'https://rubygems.org'
ruby "2.1.4"

# Core
gem 'rails', '4.2.5'
gem 'pg'
gem 'puma'

gem 'rails_12factor', group: :production

# Assets
gem 'sass-rails', '~> 5.0'
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'
gem 'bourbon', '= 3.2.4' # old bourbon, will work with libsass
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
# gem 'therubyracer', platforms: :ruby

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-lodash'
  gem 'rails-assets-es5-shim'
  gem 'rails-assets-moment'
end

gem 'omniauth'
gem 'omniauth-twitter'
gem 'twitter', '5.11.0'

# Views
gem 'haml-rails'
gem 'jbuilder', '~> 2.0'
gem 'active_model_serializers', '~> 0.9.3'

# Comments
gem 'acts_as_commentable_with_threading'

# React
gem 'react-rails', '~> 1.5.0'

# Validation
gem 'validate_url'
gem 'validate_email'

# Configuration
gem 'config'

# Error reporting
gem 'rollbar', '~> 2.4.0'

# Docs
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'interactor-rails'
gem 'active_attr'

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'

  gem 'capybara'
  gem 'poltergeist'

  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'faker'

  gem 'annotate'

  gem 'quiet_assets'
end

group :development do
  gem 'web-console', '~> 2.0'

  gem 'guard-rspec', require: false
  gem 'guard-livereload', '>= 0.4.0'
  # gem 'spring'
end
