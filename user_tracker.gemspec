# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'user_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = "user_tracker"
  spec.version       = UserTracker::VERSION
  spec.authors       = ["Michał Janeczek"]
  spec.email         = ["michal.janeczek@ymail.com"]
  spec.description   = "Track user's actions like profile update, product order and everything else you need!
                        Don't repeat yourself - just one configuration file - no duplications across controllers' actions."
  spec.summary       = "Simple action tracker. All configurations in one file!"
  spec.homepage      = "http://github.com/mjaneczek/user_tracker"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency 'analytics-ruby'
  spec.add_development_dependency 'guard-rspec'
end
