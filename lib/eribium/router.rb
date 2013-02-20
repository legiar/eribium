module Eribium
  class Router

    def initialize(application)
      @application = application
    end

    # Creates all the necessary routes for the Eribium configurations
    #
    # Use this within the routes.rb file:
    #
    #   Application.routes.draw do |map|
    #     Eribium.routes(self)
    #   end
    #
    def apply(router)
      # Define any necessary routes and root
      router.instance_exec(@application.namespaces) do |namespaces|
        namespaces.each do |namespace|
          # TODO: Eribium - HOWTO define (enable) root namespace
          unless namespace.root? or namespace.internal?
            root_route_block = Proc.new do
              root to: "base#default"
            end
            if namespace.root?
              instance_eval &root_route_block
            else
              namespace(namespace.route_key) do
                instance_eval &root_route_block
              end
            end
          end

          unless namespace.internal?
            namespace.workspaces.each do |workspace|
              route_definition_block = Proc.new do
                case workspace.type
                when "resource"
                  #resources config.resource_name.route_key, :only => config.defined_actions do
                  #  # Define any member actions
                  #  member do
                  #    config.member_actions.each do |action|
                  #      # eg: get :comment
                  #      send(action.http_verb, action.name)
                  #    end
                  #  end
                  #  # Define any collection actions
                  #  collection do
                  #    config.collection_actions.each do |action|
                  #      send(action.http_verb, action.name)
                  #    end
                  #    post :batch_action
                  #  end
                  #end
                  resources workspace.route_key
                when "page"
                  #match "/#{config.underscored_resource_name}" => "#{config.underscored_resource_name}#index"
                  match "/#{workspace.route_key}" => "#{workspace.route_key}#index"
                  #config.page_actions.each do |action|
                  #  match "/#{config.underscored_resource_name}/#{action.name}" => "#{config.underscored_resource_name}##{action.name}", :via => action.http_verb
                  #end
                else
                  raise "Unsupported workspace type: #{workspace.type}"
                end
              end

              if namespace.root?
                instance_eval &route_definition_block
              else
                namespace(namespace.route_key) do
                  instance_eval &route_definition_block
                end
              end
            end
          end
        end

        # Internal routes
        internal_definition_block = Proc.new do
          namespace :eribium do
            root to: "base#default"
            resources :namespaces
            resources :workspaces
            resources :models
          end
        end

        router.instance_eval &internal_definition_block
      end

    end
  end
end
