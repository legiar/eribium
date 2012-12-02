$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
require 'bundler'
Bundler.setup

ENV["RAILS_ENV"] ||= 'test'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

require 'eribium'

::ActiveSupport::Deprecation.silenced = false

RSpec.configure do |config|
  config.before(:all) do
    DeferredGarbageCollection.start unless ENV["DEFER_GC"] == "false"
  end
  config.after(:all) do
    DeferredGarbageCollection.reconsider unless ENV["DEFER_GC"] == "false"    
  end
end
