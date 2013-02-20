module Eribium
  module ViewHelpers
    module GravatarHelper

      def gravatar_url(user)
        email = case user
          when String
            user
          else
            user.respond_to?(:email) ? user.send(:email).to_s : ""
          end
        default_url = image_path("eribium/avatar.png")
        if email.present?
          gravatar_id = Digest::MD5.hexdigest(email.downcase)
          unless default_url =~ /^http(s)?:/
            default_url = request.base_url + default_url
          end
          gravatar_host = request.ssl? ? "https://secure.gravatar.com" : "http://gravatar.com" 
          "#{gravatar_host}/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
        else
          default_url
        end
      end

    end
  end
end