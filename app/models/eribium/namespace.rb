module Eribium

  class Namespace < ::ActiveRecord::Base
    self.table_name = :eribium_namespaces

    has_many    :workspaces,
      conditions: { parent_id: nil }, dependent: :destroy

    has_many    :all_workspaces,
      class_name: "::Eribium::Workspace"

    attr_accessible :name, :caption

    validates :name, presence: true, format: /\A[a-z][a-z0-9_]*\z/
    validates :caption, presence: true

    before_validation :set_caption_if_empty, on: :create

    def route_key
      name.underscore
    end

    #def module_name
    #  return nil if root?
    #  @module_name ||= name.to_s.camelize
    #end

    #def load!
    #  unless root? or internal?
    #    register_module
    #    create_controller([module_name, "BaseController"].compact.join("::"))
    #  end
    #  register_controller([module_name, "BaseController"].compact.join("::"))

    #  unless internal?
    #    workspaces.each do |workspace|
    #      workspace.load!
    #    end
    #  end
    #end

    #def unload!
    #  workspaces.each do |workspace|
    #    workspace.unload!
    #  end
    #end

    #def self.create_internal!
    #  namespace = Namespace.find_by_name("Eribium")
    #  unless namespace
    #    namespace = Namespace.create!(name: "Eribium", title: "Eribium") do |namespace|
    #      namespace.internal = true
    #    end
    #    namespace.workspaces.create([
    #      {name: "Dashboard", caption: "Dashboard", position: 1, icon: "icon-dashboard", type: "page"},
    #      {name: "Namespaces", caption: "Namespaces", position: 2, type: "resources"},
    #      {name: "Workspaces", caption: "Workspaces", position: 3, type: "resources"},
    #      {name: "Models", caption: "Models", position: 4, type: "resources"}
    #    ])
    #  end
    #end

    private

      def set_caption_if_empty
        self.caption = self.name.camelize if self.caption.blank?
      end

      #def register_module
      #  eval "module ::#{module_name}; end"
      #end

      #def create_controller(controller_name)
      #  eval "class ::#{controller_name} < ::Eribium::BaseController; end"
      #end

      #def register_controller(controller_name)
      #  controller = "::#{controller_name}".constantize
      #  controller.namespace = self
      #  puts controller.namespace
      #end

  end
end
