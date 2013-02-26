module Eribium
  module ViewHelpers
    module MenuHelper

      def namespace_menu
        out = "".html_safe
        out << tag(:ul, class: "nav")
        current_namespace.workspaces.each do |w|
          active = w == current_workspace || w == current_workspace.try(:parent)
          item_class = active ? "active" : ""
          dropdown = w.workspaces.size > 0
          item_class << " dropdown" if dropdown
          out << content_tag(:li, class: item_class) do
            link_class = active ? "active" : ""
            link_class << " dropdown-toggle" if dropdown
            attrs = {
              class: link_class
            }
            attrs[:data] = {toggle: "dropdown"} if dropdown
            out2 = link_to(dropdown ? "#" : "/#{current_namespace.route_key}/#{w.route_key}", attrs) do
              out1 = "".html_safe
              out1 << content_tag(:i, "", class: w.icon) if w.icon.present?
              # TODO: Eribium - locale
              out1 << w.caption
              out1 << content_tag(:b, "", class: "caret") if dropdown
              out1
            end
            out2 << child_workspaces(w) if dropdown
            out2
          end
        end
        # TODO: Eribium - logout action
        out
      end

      def child_workspaces(w)
        out = "".html_safe
        out << tag(:ul, class: "dropdown-menu")
        w.workspaces.each do |w|
          active = w == current_workspace || w == current_workspace.try(:parent)
          item_class = active ? "active" : ""
          dropdown = w.workspaces.size > 0
          item_class << " dropdown" if dropdown
          out << content_tag(:li, class: item_class) do
            link_class = active ? "active" : ""
            link_class << " dropdown-toggle" if dropdown
            attrs = {
              class: link_class
            }
            attrs[:data] = {toggle: "dropdown"} if dropdown
            out2 = link_to(dropdown ? "#" : "/#{current_namespace.route_key}/#{w.route_key}", attrs) do
              out1 = "".html_safe
              out1 << content_tag(:i, "", class: w.icon) if w.icon.present?
              out1 << w.caption
              out1 << content_tag(:b, "", class: "caret") if dropdown
              out1
            end
            out2 << child_workspaces(w) if dropdown
            out2
          end
        end
        out
      end

    end
  end
end
