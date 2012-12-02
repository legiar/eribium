require 'rails/all'

# Create a simple rails application for use in testing
module EribiumTest
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.active_support.deprecation = :stderr
  end
end

# Create base application controller
class ApplicationController < ActionController::Base
end

# Configure test application
ENV['DATABASE_URL'] = "sqlite3://tmp/test.sqlite3"

# Initialize rails application
EribiumTest::Application.initialize!

# Configure rspec for rails
require 'rspec/rails'

RSpec.configure do |config|
  #config.mock_with :rspec
end

# improve the performance of the specs suite by not logging anything
# see http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/
Rails.logger.level = 4
