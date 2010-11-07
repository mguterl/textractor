require File.expand_path("../lib/textractor/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "textractor"
  s.version     = Textractor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Michael Guterl']
  s.email       = ['michael@diminishing.org']
  s.homepage    = "http://github.com/mguterl/textractor"
  s.summary     = "simple wrapper around CLI for extracting text from PDF and Word documents"
  s.description = "simple wrapper around CLI for extracting text from PDF and Word documents"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "textractor"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec",   "~> 2.1.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.rdoc_options = ["--charset=UTF-8"]
end
