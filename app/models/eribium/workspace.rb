module Eribium

  class Workspace < ::ActiveRecord::Base
    self.table_name = :eribium_workspaces
    self.inheritance_column = :ruby_type

    belongs_to  :namespace
    belongs_to  :parent,
      class_name: "Workspace"
    has_many    :workspaces,
      foreign_key: :parent_id,
      dependent: :destroy

    default_scope order(:namespace_id, :position, :name)
    scope :root, where(parent_id: nil)

    attr_accessible :namespace_id, :parent_id, :name, :caption, :icon, :position, :type

    validates :namespace_id, presence: true
    validates :name, presence: true, format: /\A[a-z][a-z0-9_]*\z/
    validates :caption, presence: true

    before_validation :set_namespace_from_parent
    before_validation :set_caption_if_empty, on: :create

    def route_key
      name.underscore
    end

    #def load!
    #  unless namespace.internal?
    #    case type
    #    when "resource"
    #      create_workspace_controller([namespace.module_name, "#{name.classify.pluralize}Controller"].compact.join("::"))
    #    when "page"
    #      create_page_controller([namespace.module_name, "#{name.classify}Controller"].compact.join("::"))
    #    else
    #      raise "Unsupported workspace type: #{type}"
    #    end
    #  end
    #end

    #def unload!
    #end

    private

      def set_namespace_from_parent
        self.namespace_id = self.parent.try(:namespace_id) unless self.namespace_id
      end

      def set_caption_if_empty
        self.caption = self.name.camelize if self.caption.blank?
      end

      #def create_page_controller(controller_name)
      #  eval "class ::#{controller_name} < ::Eribium::PageController; end"
      #end

      #def create_workspace_controller(controller_name)
      #  eval "class ::#{controller_name} < ::Eribium::WorkspaceController
      #          defaults  route_prefix: '#{namespace.route_key}',
      #                    resource_class: #{namespace.internal? ? "::Eribium::" : ""}#{name.singularize.classify},
      #                    collection_name: '#{name.pluralize.underscore}',
      #                    instance_name: '#{name.singularize.underscore}'
      #        end"
      #end

  end

end