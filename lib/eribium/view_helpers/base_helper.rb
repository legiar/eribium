module Eribium
  module ViewHelpers
    module BaseHelper

      def resource_actions(record)
        content_tag(:div, class: "btn-group") do
          out = "".html_safe
          out << link_to(edit_resource_path(record), class: "button mini green") do
            content_tag(:i, "", class: "icon-edit")
          end
          out << link_to(resource_path(record), method: :delete, class: "button mini red", data: {confirm: "Are you sure?"}) do
            content_tag(:i, "", class: "icon-remove icon-white")
          end
        end
      end

    end
  end
end