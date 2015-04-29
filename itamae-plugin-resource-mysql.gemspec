# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/resource/mysql/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-resource-mysql"
  spec.version       = Itamae::Plugin::Resource::Mysql::VERSION
  spec.authors       = ["letusfly85"]
  spec.email         = ["letusfly95@gamil.com"]
  spec.summary       = %q{this plugin enables you to maintenance mysql service}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/letusfly85/itamae-plugin-resource-mysql"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "mysql2"
  spec.add_dependency "itamae"
end
