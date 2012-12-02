require 'eribium/router'

module Eribium
  class Application

    # TODO: Move to config
    attr_accessor :resources
    attr_accessor :default_namespace
    attr_accessor :namespaces
    attr_accessor :load_paths

    def initialize
      # TODO: Move to config
      @resources = {}
      @default_namespace = :admin1
      @namespaces = {}
      @load_paths = [File.expand_path('app/eribium', Rails.root)]      
    end

    def prepare!
      remove_from_autoload
      attach_reloader
    end

    def init!
    end

    def workspace(resource, options = {}, &block)
      name = extract_namespace_name(options)
      find_or_create_namespace(name)
      #namespace.register(resource, options, &block)
    end

    def find_or_create_namespace(name)
      name ||= :root

      if namespaces[name]
        namespace = namespaces[name]
      else
        namespace = Namespace.new(self, name)
        namespaces[name] = namespace
        ActiveSupport::Notifications.publish("eribium.namespace.register", namespace)
      end
      yield(namespace) if block_given?
      namespace
    end
    alias_method :namespace, :find_or_create_namespace

    @@loaded = false
    def loaded?
      @@loaded
    end

    def load!
      return false if loaded?
      ActiveSupport::Notifications.publish("eribium.application.before_load", self)

      load_paths.flatten.compact.uniq.
        collect{ |path| Dir["#{path}/**/*.rb"] }.flatten.
        each{ |file| load file }

      # If no configurations, let's make sure you can still login
      # TODO: Load defalut namespace
      find_or_create_namespace(default_namespace) if namespaces.values.empty?

      ActiveSupport::Notifications.publish("eribium.application.after_load", self)
      @@loaded = true
    end

    def unload!
      namespaces.values.each{ |namespace| namespace.unload! }
      @@loaded = false
    end

    def router
      @router ||= Router.new(self)
    end

    def routes(rails_router)
      load!
      router.apply(rails_router)
    end

    private

      def extract_namespace_name(options)
        options.has_key?(:namespace) ? options[:namespace] : default_namespace
      end

      def remove_from_autoload
        ActiveSupport::Dependencies.autoload_paths.reject!{|path| load_paths.include?(path) }
        Rails.application.config.eager_load_paths = Rails.application.config.eager_load_paths.reject do |path|
          load_paths.include?(path)
        end
      end

      def attach_reloader
        #Eribium::Reloader.build(Rails.application, self, Rails.version).attach!
      end

  end
end
