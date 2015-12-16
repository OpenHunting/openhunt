source 'https://rubygems.org'
ruby "2.1.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

gem 'sqlite3'
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes (very slow install)
# gem 'therubyracer', platforms: :ruby

gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'

gem 'bourbon', '= 3.2.4' # old bourbon, will work with libsass

gem 'react-rails', '~> 1.5.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'haml-rails'

# use rails assets to pull assets from bower
source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-lodash'
  gem 'rails-assets-es5-shim'
  gem 'rails-assets-oauthio-web'
end

# Build JSON APIs
gem 'jbuilder', '~> 2.0'
gem 'active_model_serializers', "~> 0.9.3"

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'annotate'
gem 'config'
gem 'interactor-rails'
gem 'active_attr'

gem "twitter", "5.11.0"

# Use puma as the app server
gem 'puma'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl'
  gem 'database_cleaner'

  gem "quiet_assets"

  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'pry-rails'

  gem 'guard-rspec', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
end
