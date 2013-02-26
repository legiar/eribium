module Eribium
  class Engine < Rails::Engine
    #isolate_namespace Eribium
    engine_name 'eribium'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "eribium.environment", :before => :load_config_initializers do |app|
      app.config.eribium = Eribium::Environment.new
      Eribium::Config = app.config.eribium

      Authorization.default_role = :user
    end

    initializer "eribium.params.filter" do |app|
      app.config.filter_parameters += [:password, :password_confirmation]
    end

    initializer "eribium.assets", group: :all do |app|
      app.config.assets.precompile += %w[
        jquery.js
        modernizr.js
        eribium.js
        eribium.css
      ]
      #stylesheets = File.expand_path(File.join('vendor', 'assets', 'stylesheets'))
      #puts stylesheets
      #::Sass.load_paths << stylesheets
      #puts ::Sass.load_paths
    end

    initializer "eribium.autoload.paths" do |app|
      ActiveSupport::Dependencies.autoload_paths.reject! do |path|
        app.config.eribium.load_paths.include?(path)
      end
      app.config.eager_load_paths = app.config.eager_load_paths.reject do |path|
        app.config.eribium.load_paths.include?(path)
      end
    end

    config.after_initialize do
      ActiveSupport::Notifications.subscribe(/^eribium\./) do |*args|
        event_name, start_time, end_time, id, payload = args
        Activator.active.event_name_starts_with(event_name).each do |activator|
          payload[:event_name] = event_name
          activator.activate(payload)
        end
      end
    end

    # We need to reload the routes here due to how Eribium sets them up.
    # The extensions for Eribium (auth, promo, etc.) append/prepend routes to Eribium
    # *after* Eribium has been loaded.
    #
    # So we wait until after initialization is complete to do one final reload.
    # This then makes the appended/prepended routes available to the application.
    config.after_initialize do
      Rails.application.routes_reloader.reload!
    end

  end
end
