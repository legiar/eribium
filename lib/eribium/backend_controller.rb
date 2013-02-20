module Eribium
  class BackendController < ::ApplicationController

    layout "eribium"

    before_filter :authenticate_eribium_user
    #before_filter :check_admin_access

    #add_breadcrumb I18n.t("nav.main"), :admin_root_path

    protected

      def authenticate_eribium_user
        true
      end

      def check_admin_access
        authorize! :access_admin, nil
      end

    end
end