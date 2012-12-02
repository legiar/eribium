module Eribium

  class BaseController < ::ApplicationController
    layout "eribium"

    before_filter :authenticate_eribium_user

    private

      def authenticate_eribium_user
        #send(eribium_namespace.authentication_method) if eribium_namespace.authentication_method
      end

      def current_eribium_user
        #send(namespace.current_user_method) if eribium_namespace.current_user_method
      end
      helper_method :current_eribium_user

      def current_eribium_user?
        !current_eribium_user.nil?
      end
      helper_method :current_eribium_user?

      def eribium_config
        self.class.eribium_config
      end
      helper_method :eribium_config

      def eribium_namespace
        eribium_config.namespace
      end
      helper_method :eribium_namespace

  end
  
end