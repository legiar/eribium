# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'eribium/version'

Gem::Specification.new do |s|
  s.name          = "eribium"
  s.version       = Eribium::VERSION

  s.authors       = ["Mikhail Mikhaliov"]
  s.email         = ["legiar@gmail.com"]
  s.description   = %q{TODO: Write a gem description}
  s.summary       = %q{TODO: Write a gem summary}
  s.homepage      = ""

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails',                 '>= 3.2.0'
  s.add_dependency 'jquery-rails'
  #s.add_dependency 'meta_search',           '>= 0.9.2'
  s.add_dependency 'devise',                '>= 2.1.0'
  s.add_dependency 'simple_form',           '>= 2.0.0'
  s.add_dependency 'inherited_resources',   '>= 1.3.1'
  #s.add_dependency 'kaminari',        '>= 0.13.0'
  s.add_dependency 'arbre',                 '>= 1.0.1'

  s.add_dependency 'modernizr',             '2.6.2'
  s.add_dependency 'bootstrap-sass',        '2.2.1.1'

  s.add_development_dependency 'yard'
  s.add_development_dependency 'rdiscount'
end
