module Eribium
  module ViewHelpers
    module FlashHelper

      def flash_messages
        messages = []
        flash.each do |type, message|
          type = :success if type == :notice
          type = :error   if type == :alert
          if message.is_a? String
            messages << "noty({text: '#{message}', dismissQueue: true, timeout: 3000, type: '#{type}'});"
          end
        end
        messages.empty? ? "".html_safe : 
          javascript_tag("jQuery(function() { #{messages.join("\n")} });")
      end
      
    end
  end
end
