$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "privat24/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "privat24"
  s.version     = Privat24::VERSION
  s.authors     = ["Vadim Lazebny"]
  s.email       = ["vadim.lazebny@gmail.com"]
  s.homepage    = "https://github.com/lazebny/privat24"
  s.summary     = %q(Privat24 in Ruby)
  s.description = %q(Privat24 in Ruby)

  s.files = Dir["{app,config,db,lib}/**/*"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'rake'
  # s.add_development_dependency "sqlite3"
end
