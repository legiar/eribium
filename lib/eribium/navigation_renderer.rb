#require 'simple_navigation/rendering'

module Eribium

  class NavigationRenderer < SimpleNavigation::Renderer::Base

    def render(container)
      SimpleNavigation.config.selected_class = 'active'
      
      content = container.items.inject([]) do |list, item|
        li_options = item.html_options.reject {|k, v| k == :link}
        li_content = tag_for(item, li_options.delete(:icon))
        if include_sub_navigation?(item)
          item.sub_navigation.dom_class = [item.sub_navigation.dom_class, 'dropdown-menu'].flatten.compact.join(' ')
          li_content << render_sub_navigation_for(item)
          li_options[:class] = [li_options[:class], 'dropdown'].flatten.compact.join(' ')
        end
        list << content_tag(:li, li_content, li_options)
      end.join

      content_tag(:ul, content, id: container.dom_id, class: "#{container.dom_class}#{container.level == 1 ? " nav" : ""}")
    end

    protected

    def tag_for(item, icon = nil)
      unless item.url or include_sub_navigation?(item)
        return item.name
      end
      url = item.url
      link = Array.new
      link << content_tag(:i, '', :class => [icon].flatten.compact.join(' ')) unless icon.nil?
      link << item.name
      if include_sub_navigation?(item)
        url = '#'
        item_options = item.html_options
        item_options[:link] = Hash.new if item_options[:link].nil?
        item_options[:link][:class] = Array.new if item_options[:link][:class].nil?
        item_options[:link][:class] << 'dropdown-toggle'
        item_options[:link][:'data-toggle'] = 'dropdown'
        item.html_options = item_options
        link << content_tag(:b, '', :class => 'caret')
      end
      link_to(link.join(" "), url, options_for(item))
    end
  end

end
