# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fusioncharts/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "fusioncharts-rails"
  spec.version       = Fusioncharts::Rails::VERSION
  spec.authors       = ["FusionCharts"]
  spec.email         = ["mail@labs.fusioncharts.com"]
  spec.description   = %q{Server Wrapper for rendering FusionCharts on Rails}
  spec.summary       = %q{Wrapper for fusioncharts}
  spec.homepage      = "https://github.com/fusioncharts/rails-wrapper"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails", ">= 3.2"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "simplecov"

end
