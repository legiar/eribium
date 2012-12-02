module Eribium

  class Namespace

    #RegisterEvent = 'eribium.namespace.register'.freeze

    attr_reader :application,
                :name,
                :menu
                #:resources

    def initialize(application, name)
      @application = application
      @name = name.to_s.underscore.to_sym
      register_module

      # Create Dashboard controller
      create_controller([module_name, "DashboardController"].compact.join("::"))
    end

    def register_page
    end

    def register_resource
    end

    def register_workspace
    end

    def root?
      name == :root
    end

    def module_name
      return nil if root?
      @module_name ||= name.to_s.camelize
    end

    def unload!
    end

    private

      def register_module
        eval "module ::#{module_name}; end"
      end

      def create_controller(controller_name)
        eval "class ::#{controller_name} < Eribium::PageController; end"
      end

  end
end
