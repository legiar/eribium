source 'https://rubygems.org'

# Specify your gem's dependencies in eribium.gemspec
gemspec

gem 'sass-rails'

group :development, :test do
  gem 'sqlite3'
  #gem 'rake',           '~> 0.9.2.2', :require => false
  #gem 'haml',           '~> 3.1.7', :require => false
  #gem 'yard'
  #gem 'rdiscount' # For yard
  #gem 'sprockets'
  #gem 'rails-i18n' # Gives us default i18n for many languages
  #gem 'parallel_tests'

  gem 'rb-fsevent',                 require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'rb-inotify',                 require: false if RUBY_PLATFORM =~ /linux/i
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  #gem 'cucumber-rails', '1.3.0', :require => false
  #gem 'capybara',       '1.1.2'
  #gem 'database_cleaner'
  #gem 'launchy'
  #gem 'jslint_on_rails',    '~> 1.1.1'
  gem 'guard-rspec'
  #gem "guard-coffeescript"
  #gem 'jasmine'
end

