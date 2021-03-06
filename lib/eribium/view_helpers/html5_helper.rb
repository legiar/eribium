module Eribium
  module ViewHelpers
    module Html5Helper

      # Helper to display conditional html tags for IE
      # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither
      def html_tag(attrs={})
        attrs.symbolize_keys!

        html = ""
        html << "<!--[if lt IE 7]> #{tag(:html, add_class('ie6', attrs), true)} <![endif]-->\n"
        html << "<!--[if IE 7]>    #{tag(:html, add_class('ie7', attrs), true)} <![endif]-->\n"
        html << "<!--[if IE 8]>    #{tag(:html, add_class('ie8', attrs), true)} <![endif]-->\n"
        html << "<!--[if IE 9]>    #{tag(:html, add_class('ie9', attrs), true)} <![endif]-->\n"
        html << "<!--[if (gt IE 9)|!(IE)]><!--> "

        if block_given? && defined? Haml
          haml_concat(html.html_safe)
          haml_tag :html, attrs do
            haml_concat("<!--<![endif]-->".html_safe)
            yield
          end
        else
          html = html.html_safe
          html << tag(:html, attrs, true)
          html << " <!--<![endif]-->\n".html_safe
          html
        end
      end

      private

        def add_class(name, attrs)
          classes = attrs[:class] || ""
          classes.strip!
          classes = " " + classes if !classes.blank?
          classes = name + classes
          attrs.merge(class: classes)
        end
        
    end
  end
end