module Eribium

  class WorkspaceController < BaseController
    inherit_resources

    responders :flash

    respond_to :html

    def index
    end

    #def create
    #  create! { collection_path }
    #end

    #def update
    #  update! { collection_path }
    #end

    protected

  end
  
end