require 'yaml'
require 'erb'
require 'open-uri'

module Eribium
  class Environment
    # TODO: May be use ActiveSupport::Configurable
    # TODO: Also see https://github.com/metaskills/store_configurable
    include Eribium::Settings

    setting :load_paths, [File.expand_path('app/eribium', Rails.root)]
    setting :site_name, Rails.application.class.parent.name
    setting :site_title, Rails.application.class.parent.name

    def initialize
      config = Rails.root.join("config", "eribium.yml")
      if File.exists?(config)
        content = open(config).read
        hash = content.empty? ? {} : YAML.load(ERB.new(content).result).to_hash
        hash[Rails.env].each do |key, val|
          self.class.setting key.to_sym, val
        end
      end
    end

  end
end
