$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "privat24/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "privat24"
  s.version     = Privat24::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Privat24."
  s.description = "TODO: Description of Privat24."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
