# -*- encoding: utf-8 -*-
require File.expand_path(File.join('..', 'lib', 'omniauth-dataporten', 'version'), __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'

  gem.name          = 'omniauth-dataporten'
  gem.version       = Omniauth::Dataporten::VERSION
  gem.authors       = ['kasperrt']
  gem.email         = ['kasper@kasperrt.no']
  gem.description   = %q{A Dataporten OAuth2 strategy for OmniAuth 1.x}
  gem.summary       = %q{A Dataporten OAuth2 strategy for OmniAuth 1.x}
  gem.homepage      = 'https://github.com/kasperrt/omniauth-dataporten'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.0'

  gem.add_development_dependency 'rspec', '~> 2.6.0'
end