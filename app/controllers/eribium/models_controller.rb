module Eribium

  class ModelsController < WorkspaceController
    defaults  route_prefix: 'eribium',
              resource_class: Model,
              collection_name: 'models',
              instance_name: 'model'

    def new
      if params[:import]
        import
        redirect_to collection_path
      else
        new!
      end
    end

    def create
      create! { collection_path }
    end

    def update
      update! { collection_path }
    end

    protected

      def import
        # TODO: Subdir support
        models = []
        Rails.root.join("app/models").each_child(true) do |file|
          unless file.directory?
            name = file.basename(".rb").to_s
            unless name =~ /_translation$/
              model_name = name.classify

              klass = model_name.constantize
              if klass.respond_to?(:descends_from_active_record?) and klass.descends_from_active_record?
                models << model_name
              end
            end
          end
        end

        models.each do |name|
          unless Eribium::Model.find_by_name(name)
            Eribium::Model.new(name: name, caption: name) do |model|
              model.skip_check_exists = true
              model.save!
            end
          end
        end
        #render text: models
      end

  end

end