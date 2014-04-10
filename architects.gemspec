$:.push File.expand_path("../lib", __FILE__)
require 'architects/version'

Gem::Specification.new do |s|
  s.name          = "architects"
  s.version       = Architects::Version
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Jonathan Soeder"]
  s.email         = ["jonathan.soeder@gmail.com"] 
  s.homepage      = "http://architects.io"
  s.summary       = "Tools for Software Architects"
  s.description   = "A tool for designing, documenting, and testing APIs "

  s.add_dependency 'activesupport', '>= 4.0.0'
  s.add_dependency 'rspec_api_documentation'

  s.add_development_dependency 'rspec', '~> 2.6.0'
  s.add_development_dependency 'machinist', '~> 1.0.6'
  s.add_development_dependency 'faker', '~> 0.9.5'
  s.add_development_dependency 'sqlite3', '~> 1.3.3'
  s.add_development_dependency 'rack-test'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
