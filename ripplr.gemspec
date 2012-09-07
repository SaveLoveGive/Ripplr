$:.push File.expand_path('../lib', __FILE__)
require 'ripplr/version'

Gem::Specification.new do |gem|
  # Meta
  gem.name = "ripplr"
  gem.version = Ripplr::VERSION
  gem.summary = "Ripplr is a library to ease the use of Riak Search from within Rails when using Ripple and Riak Client."
  gem.description = "Ripplr provides a lower barrier to entry for developers wishing to migrate to Riak. Ripplr focuses on enhancing the use of the Ripple Gem by adding Riak Search functionality to your objects."
  gem.email = ["msnyder@validas.com"]
  gem.homepage = "https://github.com/validas/Ripplr"
  gem.authors = ["Matt Snyder"]

  # Deps
  gem.add_development_dependency "rspec-given", ">= 1.6.0"
  gem.add_development_dependency "rake"
  gem.add_dependency "ripple", ">= 0.9.5"

  # Files
  ignores = File.read(".gitignore").split(/\r?\n/).reject{ |f| f =~ /^(#.+|\s*)$/ }.map {|f| Dir[f] }.flatten
  gem.files         = (Dir['**/*','.gitignore'] - ignores).reject {|f| !File.file?(f) }
  gem.test_files    = (Dir['spec/**/*','.gitignore'] - ignores).reject {|f| !File.file?(f) }
  gem.require_paths = ['lib']
end
