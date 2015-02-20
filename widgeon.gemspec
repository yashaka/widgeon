# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'widgeon/version'

Gem::Specification.new do |spec|
  spec.name          = "widgeon"
  spec.version       = Widgeon::VERSION
  spec.authors       = ["Iakiv Kramarenko"]
  spec.email         = ["yashaka@gmail.com"]
  spec.summary       = %q{Yet another page objects for Capybara of 2.0.3 version and ruby 1.8.7}
  spec.description   = %q{Yet another page objects for Capybara of 2.0.3 version, i.e. compatible with ruby 1.8.7}
  spec.homepage      = "https://github.com/yashaka/widgeon"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri' , '~>1.5.10'
  spec.add_dependency 'mime-types', '= 1.25'
  spec.add_dependency 'capybara', '= 2.0.3'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
