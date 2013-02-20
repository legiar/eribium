module Eribium
  module Helpers

    Dir[File.expand_path('../helpers', __FILE__) + "/**/*.rb"].sort.each{ |f| require f }
    
  end
end