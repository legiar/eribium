# encoding: UTF-8
require File.expand_path('../lib/eribium/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "eribium"
  s.version       = Eribium::VERSION
  s.platform      = Gem::Platform::RUBY
  s.homepage      = "https://github.com/legiar/eribium"
  s.authors       = ["Mikhail Mikhaliov"]
  s.email         = ["legiar@gmail.com"]
  s.description   = "Gem for create CRM-like admin area"
  s.summary       = "Gem for create CRM-like admin area"

  s.license       = "MIT"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails',                 '~> 3.2'

  s.add_dependency 'inherited_resources',   '>= 1.3.1'
  s.add_dependency 'meta_search',           '>= 0.9.2'
  s.add_dependency 'kaminari',              '>= 0.14.0'
  s.add_dependency 'state_machine',         '>= 1.1.2'

  s.add_dependency 'devise',                '>= 2.1.0'
  s.add_dependency 'rolify',                '>= 3.2.0'
  s.add_dependency 'cancan',                '>= 1.6.8'
  
  s.add_dependency 'slim-rails',            '>= 1.0.3'
  
  s.add_dependency 'simple-navigation',     '>= 3.7.0'

  s.add_dependency 'simple_form',           '>= 2.0.0'
  s.add_dependency 'nested_form',           '>= 0.3.1'
  
  s.add_dependency 'sass-rails',            '>= 3.2.3'
  s.add_dependency 'modernizr',             '>= 2.6.0'
  s.add_dependency 'bootstrap-sass',        '~> 2.3.0'
  s.add_dependency 'jquery-rails',          '~> 2.2.1'
  s.add_dependency 'jquery-rails-cdn'
  s.add_dependency 'select2-rails',         '~> 3.2'

  s.add_dependency 'arbre',                 '>= 1.0.1'

  #s.add_development_dependency 'yard'
  #s.add_development_dependency 'rdiscount'
end
