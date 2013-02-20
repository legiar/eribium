module Eribium
  module ViewHelpers

    Dir[File.expand_path('../view_helpers', __FILE__) + "/*.rb"].each do |file|
      require file
      klass_name = File.basename(file, ".rb").classify
      klass_name = "Eribium::ViewHelpers::#{klass_name}"
      include klass_name.constantize
    end

  end
end
