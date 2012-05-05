# -*- encoding: utf-8 -*-
require File.expand_path('../lib/little_fish/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["yeer"]
  gem.email         = ["athom@126.com"]
  gem.description   = %q{my first toy gem}
  gem.summary       = %q{it's just pulling data from website boston bigpicture}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "little_fish"
  gem.require_paths = ["lib"]
  gem.version       = LittleFish::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'nokogiri'

end
