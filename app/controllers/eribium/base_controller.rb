module Eribium

  class BaseController < ::ApplicationController
    #before_filter :authenticate_eribium_user
    # TODO: Eribium - remove in future
    #before_filter :set_views_path
    #before_filter :set_locale

    layout "eribium"

    #class << self
    #  attr_accessor :namespace
    #  attr_accessor :workspace
    #end

    def default
      #return render inline: "<%= debug current_namespace %>"
      # Redirect default workspace
      # TODO: Eribium - move default workspace to system settings
      if workspace = current_namespace.workspaces.root.first
        # TODO: Eribium - make workspace path method
        redirect_to "/#{current_namespace.route_key}/#{workspace.route_key}"
      else
        # TODO: Eribium - error: namespace without workspaces
        raise "No workspaces"
      end
    end

    protected

      #def set_views_path
      #  prepend_view_path "app/views/#{current_namespace.name.underscore}"
      #end

      #def set_locale
      #  unless locale = params[:locale]
      #    locale = I18n.default_locale
      #  end
      #  I18n.locale = locale
      #end

      #def default_url_options
      #  if I18n.locale == I18n.default_locale
      #    {}
      #  else
      #    {locale: I18n.locale}
      #  end
      #end

    private

      #ERIBIUM_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]
      
      #def determine_eribium_layout
      #  ERIBIUM_ACTIONS.include?(params[:action].to_sym) ? false : 'eribium'
      #end

      def current_namespace
        unless @current_namespace
          class_name = self.class.name
          if class_name.include?('::')
            namespace_name = class_name.split('::').first.underscore
            @current_namespace = Namespace.find_by_name(namespace_name)
            unless @current_namespace
              if Rails.env.development?
                @current_namespace = Namespace.create(name: namespace_name)
              end
            end
          else
            @current_namespace = Namespace.where(root: true).first
            unless @current_namespace
              if Rails.env.development?
                @current_namespace = Namespace.create(name: root, root: true)
              end
            end
          end
        end

        raise "Namespace not found" unless @current_namespace
        @current_namespace
      end
      helper_method :current_namespace

      def current_workspace
        unless @current_workspace
          class_name = self.class.name
          if class_name.include?('::')
            class_name = self.class.name.split('::').last
          end
          workspace_name = class_name.split('Controller').first.underscore
          @current_workspace = current_namespace.all_workspaces.find_by_name(workspace_name)

          unless @current_workspace
            if Rails.env.development?
              @current_workspace = current_namespace.workspaces.create(name: workspace_name)
            end
          end
        end

        raise "Workspace not found" unless @current_workspace
        @current_workspace
      end
      helper_method :current_workspace

  end
  
end