# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'eribium/version'

Gem::Specification.new do |s|
  s.name          = "eribium"
  s.version       = Eribium::VERSION

  s.authors       = ["Mikhail Mikhaliov"]
  s.email         = ["legiar@gmail.com"]
  s.description   = %q{Gem for create CRM-like system}
  s.summary       = %q{Gem for create CRM-like system}
  s.homepage      = "https://github.com/legiar/eribium"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails',                 '>= 3.2.0'

  s.add_dependency 'inherited_resources',   '>= 1.3.1'
  s.add_dependency 'meta_search',           '>= 0.9.2'
  s.add_dependency 'kaminari',              '>= 0.14.0'

  s.add_dependency 'state_machine',         '>= 1.0.1'

  s.add_dependency 'devise',                '>= 2.1.0'
  s.add_dependency 'rolify',                '>= 3.2.0'
  s.add_dependency 'cancan',                '>= 1.6.8'
  
  s.add_dependency 'slim-rails',            '>= 1.0.3'
  s.add_dependency 'simple_form',           '>= 2.0.0'
  s.add_dependency 'nested_form',           '>= 0.3.1'
  
  s.add_dependency 'sass-rails',            '>= 3.2.3'
  s.add_dependency 'modernizr',             '2.6.2'
  s.add_dependency 'bootstrap-sass',        '2.2.2.0'
  s.add_dependency 'jquery-rails'

  s.add_dependency 'arbre',                 '>= 1.0.1'

  s.add_development_dependency 'yard'
  s.add_development_dependency 'rdiscount'
end
