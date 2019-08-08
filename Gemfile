source 'https://rubygems.org'
ruby '2.5.1'

gem 'rb-readline'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

# Text editor
gem 'responders'
gem "non-stupid-digest-assets"
gem 'rails-html-sanitizer'


# Use ActiveModel has_secure_password
gem 'bcrypt'

# Cloning gem
gem 'amoeba'

# Bower for Angular dependency management
gem 'bower-rails'

# Angular html-files to Assets Pipeline
gem "angular-rails-templates"
gem "sprockets"

group :test do
  
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', require: false

  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'rspec-mocks'
  gem 'poltergeist'
  gem 'phantomjs'

  # Gem for retrying failing specs
  gem 'rspec-retry'
end

group :development do

  # For creating a seed from database
  gem 'seed_dump'

  #Automating deployments with Capistrano

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'

  # Remove the following if your app does not use Rails
  gem 'capistrano-rails'

  # Remove the following if your server does not use RVM
  gem 'capistrano-rvm'
  
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end


group :development, :test do

  # RSpec for testing
  gem 'rspec-rails'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

end

group :production, :staging do
 
  # Use postgresql for Heroku
  gem 'pg'

  # This gem is also required for Heroku
  gem 'rails_12factor'

end
