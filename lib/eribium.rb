require 'inherited_resources'
#require 'meta_search'
#require 'kaminari'

#require 'state_machine'
#require 'paperclip'

require 'devise'
# TODO: Detect if cancan used
#require 'cancan'
# TODO: Detect if rolify used
#require 'rolify'

require 'simple_form'

require 'bootstrap-sass'
require 'modernizr'

require 'jquery-rails'

require 'eribium/engine'

module Eribium
  autoload :VERSION,                  'eribium/version'

  autoload :Application,              'eribium/application'

  autoload :Namespace,                'eribium/models/namespace'
  autoload :Page,                     'eribium/models/page'
  autoload :Resource,                 'eribium/models/resource'
  autoload :Workspace,                'eribium/models/workspace'

  autoload :BaseController,           'eribium/controllers/base_controller'
  autoload :PageController,           'eribium/controllers/page_controller'
  autoload :ResourceController,       'eribium/controllers/resource_controller'
  autoload :WorkspaceController,      'eribium/controllers/workspace_controller'

  class << self
    attr_accessor :application

    def application
      @application ||= ::Eribium::Application.new
    end

    def config
      application.prepare!
      yield(application)
      application.init!
    end

    delegate :resource, to: :application
    delegate :workspace, to: :application
    delegate :routes,    to: :application

    def before_load(&block)
      ActiveSupport::Notifications.subscribe("eribium.application.before_load") do |event, app, *args|
        block.call(app)
      end
    end

    def after_load(&block)
      ActiveSupport::Notifications.subscribe("eribium.application.after_load") do |event, app, *args|
        block.call(app)
      end
    end

  end

end
