require 'inherited_resources'
require 'meta_search'
require 'kaminari'

require 'state_machine'
#require 'paperclip'

require 'devise'
require 'declarative_authorization'

require 'slim'
require 'arbre'

require 'simple-navigation'

require 'simple_form'
require 'nested_form'

require 'modernizr'
require 'jquery-rails'
require 'jquery-rails-cdn'
require 'select2-rails'
require 'bootstrap-sass'

require 'eribium/engine'

module Eribium
  extend ActiveSupport::Autoload
  autoload :VERSION
  autoload :Environment
  autoload :Settings

  autoload :BackendController

  #autoload :Application,              'eribium/application'
  #autoload :Router,                   'eribium/router'

  #autoload :Namespace,                'eribium/models/namespace'
  #autoload :Workspace,                'eribium/models/workspace'
  #autoload :Model,                    'eribium/models/model'

  #autoload :BaseController,           'eribium/controllers/base_controller'
  #autoload :PageController,           'eribium/controllers/page_controller'
  #autoload :WorkspaceController,      'eribium/controllers/workspace_controller'

  #autoload :NamespacesController,     'eribium/controllers/namespaces_controller'
  #autoload :WorkspacesController,     'eribium/controllers/workspaces_controller'
  #autoload :ModelsController,         'eribium/controllers/models_controller'
  
  #autoload :Helpers,                  'eribium/helpers'
  #autoload :Views,                    'eribium/views'

  autoload :NavigationRenderer
  autoload :ViewHelpers

  class << self
    attr_accessor :application

    def application
      @application ||= ::Eribium::Application.new
    end

    def config
      yield Eribium::Config if block_given?
      Eribium::Config
    end

    #delegate :resource, to: :application
    #delegate :workspace, to: :application
    delegate :routes, to: :application

    def before_load(&block)
      ActiveSupport::Notifications.subscribe("eribium.application.load.before") do |event, app, *args|
        block.call(app)
      end
    end

    def after_load(&block)
      ActiveSupport::Notifications.subscribe("eribium.application.load.after") do |event, app, *args|
        block.call(app)
      end
    end

  end

end

# ActionView helpers
if defined?(ActionView)
  ActionView::Base.class_eval do
    include Eribium::ViewHelpers
  end
end

# SimpleNavigaton renderer
SimpleNavigation.default_renderer = Eribium::NavigationRenderer
